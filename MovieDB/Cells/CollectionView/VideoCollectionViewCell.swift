//
//  VideoCollectionViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 19/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Video cell - thumbnail video image
//  Used in HorizontalCollection

import Foundation
import UIKit

class VideoCollectionViewCell: HorizontalCollectionCell {
    
    // MARK: - Variables
    
    private lazy var playImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.play())
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        return imageView
    }()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = UIColor.clear
    }
    
    private func setupConstraints() {
        playImageView.snp.makeConstraints({ (make) in
            make.width.height.equalTo(24)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        })
    }
    
}
