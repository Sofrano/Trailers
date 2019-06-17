//
//  ProductionStatusProductionStatusTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 03/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Сell with current movie status information

import Foundation
import TableKit

class ProductionStatusTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Variables
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.appColor.peterRiver
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var notifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.bell(), for: .normal)
        button.tintColor = UIColor.white
        contentView.addSubview(button)
        return button
    }()
    
    private lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        contentView.addSubview(view)
        return view
    }()
    
    private var viewModel: ProductionCellViewModel?
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: ProductionCellViewModel) {
        self.viewModel = data
        titleLabel.text = viewModel?.title
        statusLabel.text = viewModel?.value
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        contentView.superview?.clipsToBounds = false
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        notifyButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        topLineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}
