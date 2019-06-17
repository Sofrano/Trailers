//
//  YTPlayerYTPlayerTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Youtube cell with gradient and description

import Foundation
import TableKit


class YTPlayerTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Variables
    
    private lazy var thumbImageView: YTImageView = {
        let imageView = YTImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        contentView.addSubview(view)
        return view
    }()
    
    private var topGradient: CAGradientLayer = CAGradientLayer()
    
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
    
    func configure(with data: YTPlayerCellViewModel) {
        thumbImageView.loadThumbnail(for: data.videoId,
                                     quality: .high)
        nameLabel.text = data.name
        nameLabel.sizeToFit()
        contentView.bringSubviewToFront(nameLabel)
        setupTitleGradient()
    }
    
    // MARK: - Override Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        backgroundColor = UIColor.clear
    }
    
    private func setupConstraints() {
        thumbImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(thumbImageView.snp.width).multipliedBy(0.56)
            make.bottom.equalToSuperview().offset(-1).priority(.medium)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(thumbImageView)
            make.height.equalTo(1)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(5)
        }
    }
    
    private func setupTitleGradient() {
        topGradient.removeFromSuperlayer()
        topGradient = CAGradientLayer()
        topGradient.colors = [UIColor.appColor.behance.cgColor, UIColor.clear.cgColor]
        topGradient.locations = [0.0 , 1.0]
        topGradient.frame = CGRect(x: 0.0, y: 0, width: self.frame.size.width, height: nameLabel.frame.size.height + 10)
        contentView.layer.insertSublayer(topGradient, below: nameLabel.layer)
    }
    
}

