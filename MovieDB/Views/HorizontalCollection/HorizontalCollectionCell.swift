//
//  HorizontalCollectionCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 11/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

public class HorizontalCollectionCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
