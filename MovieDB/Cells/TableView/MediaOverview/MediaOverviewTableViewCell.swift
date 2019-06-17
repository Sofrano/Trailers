//
//  ImageOverviewImageOverviewTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 10/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Short Overview with poster and Action Button

import Foundation
import TableKit

class MediaOverviewTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Variables
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.appColor.peterRiver
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.setImage(R.image.add(), for: .normal)
        button.tintColor = UIColor.white
        button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: 10,
                                                    bottom: 0,
                                                    right: 0)
        contentView.addSubview(button)
        return button
    }()
    
    private var viewModel: MediaOverviewViewModel?
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: MediaOverviewViewModel) {
        self.viewModel = data
        posterImageView.kf.setImage(with: viewModel?.posterUrl)
        overviewLabel.text = viewModel?.text
        actionButton.setTitle(data.actionTitle, for: .normal)
    }
    
    static var defaultHeight: CGFloat? { return 152 }
    
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
    
    // MARK: - Private Functions
    
    private func setupViews() {
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(120).priority(.high)
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            make.bottom.equalTo(posterImageView)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.top.equalTo(posterImageView).offset(-4)
            make.right.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualTo(actionButton.snp.top).offset(-8)
        }
    }
    
    // Reminder Settings
    @objc private func buttonAction() {
        viewModel?.invoke(action: .watchlist)
    }
    
}
