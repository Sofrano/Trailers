//
//  HorizontalCollectionHorizontalCollectionTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 11/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Horizontal scrolling item cell

import Foundation
import TableKit
import SnapKit
import UIKit

class HorizontalCollectionTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Private Variables
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.seeAll(), for: .normal)
        button.setTitleColor(UIColor.appColor.peterRiver, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self,
                         action: #selector(seeAll),
                         for: .touchUpInside)
        contentView.addSubview(button)
        return button
    }()
    
    private lazy var collectionView: HorizontalCollectionView = {
        let collectionView = HorizontalCollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))
        collectionView.register(HorizontalCollectionCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        return collectionView
    }()
    
    private var cellIdentifier: String = "cell"
    private var viewModel: SectionImageCollectionViewModel?
    private var configuration = HorizontalCollectionConfiguration()
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialView()
        setupConstraints()
    }
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: SectionImageCollectionViewModel) {
        viewModel = data
        configuration = (data.configuration as? HorizontalCollectionConfiguration) ?? HorizontalCollectionConfiguration()
        guard let viewModel = viewModel else { return }
        titleLabel.text  = viewModel.title
        counterLabel.text = String(viewModel.URLs.count)
        setupCollectionView(configuration: configuration)
        configuration.onConfigureView(self)
    }
    
    // MARK: - Private Functions
    
    private func setupCollectionView(configuration: HorizontalCollectionConfiguration) {
        collectionView.itemSize = configuration.itemSize
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(configuration.itemSize)
        }
        collectionView.interitemSpacing = configuration.interitemItemSpacing
        if let registerCell = configuration.registerCell {
            collectionView.register(registerCell.class, forCellWithReuseIdentifier: registerCell.identifier)
            cellIdentifier = registerCell.identifier
        }
        collectionView.reload()
    }
    
    private func setupInitialView() {
        self.backgroundColor = UIColor.appColor.balticSea
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
        }
        
        counterLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(8)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-8)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8).priority(.medium)
            make.height.equalTo(150)
        }
    }
    
    // Button press event
    @objc private func seeAll() {
        viewModel?.invoke(action: .openDetails)
    }
    
}

extension HorizontalCollectionTableViewCell: HorizontalCollectionViewDataSource {
    
    func numberOfItems(in collectionView: HorizontalCollectionView) -> Int {
        return viewModel?.URLs.count ?? 0
    }
    
    func collectionView(_ collectionView: HorizontalCollectionView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, at: index)
        let url = viewModel?.URLs[index]
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.kf.indicatorType = .activity
        (cell.imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        cell.imageView.kf.setImage(with: url)
        
        // We give the opportunity to make adjustments from the outside.
        configuration.configureCollectionCell(cell, index)
        
        return cell
    }
    
    
}

extension HorizontalCollectionTableViewCell: HorizontalCollectionViewDelegate {
    
    func collectionView(_ collectionView: HorizontalCollectionView, didSelectItemAt index: Int) {
        viewModel?.invoke(action: .selectItem(index: index))
    }
    
}
