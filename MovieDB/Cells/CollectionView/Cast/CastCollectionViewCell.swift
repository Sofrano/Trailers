//
//  CastCollectionViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 12/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Role cell - avatar, name and character name
//  Used in HorizontalCollection

import Foundation
import UIKit

class CastCollectionViewCell: HorizontalCollectionCell {
    
    // MARK: - Variables
    
    public lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.font = configuration.characterFont
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = configuration.nameFont
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    
    private var configuration = CastCellConfiguration() {
        didSet {
            characterLabel.font = configuration.characterFont
            nameLabel.font = configuration.nameFont
        }
    }
    
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
    
    // MARK: - Public Functions
    
    public func configure(_ viewModel: CastCellViewModel) {
        self.characterLabel.text = viewModel.character
        self.nameLabel.text = viewModel.name
        if let imageURL = viewModel.imageURL {
            self.imageView.kf.setImage(with: imageURL)
        }
        if let configuration = viewModel.configuration as? CastCellConfiguration {
            self.configuration = configuration
        }
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        self.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        (imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
        imageView.snp.remakeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(4)
        }
        characterLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(0)
        }
        
    }
    
}
