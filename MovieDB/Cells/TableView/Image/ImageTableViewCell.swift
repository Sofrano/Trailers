//
//  ImageImageTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 12/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Cell with ImageView, used by Image Gallery (ImageListViewController.swift)

import Foundation
import TableKit
import Kingfisher

class ImageTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Variables
    
    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        (imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
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
    
    func configure(with data: ImageCellViewModel) {
        myImageView.kf.setImage(with: data.imageURL)
        if let aspectRatio = data.aspectRatio {
            let height = self.frame.width / CGFloat(aspectRatio)
            myImageView.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
        }
    }

    // MARK: - Override Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private Functions
    
    private func setupInitialView() {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        let height = self.frame.width * (9.0 / 16.0)
        myImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(height)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
}

