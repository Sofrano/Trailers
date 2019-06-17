//
//  MovieTitleMovieTitleTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Cell with a summary of the film and its rating

import Foundation
import TableKit
import SnapKit

class MovieShortDescriptionTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Variables
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(label)
        return label
    }()
    
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
    
    func configure(with data: (MovieShortDescriptionCellViewModel)) {
        titleLabel.text = data.title
        let genres = data.genreNames
        descriptionLabel.text = "\(data.year) \(genres)"
        voteLabel.text = " \(data.voteAverage) "
        switch data.voteAverage {
        case 1...5.99:
            voteLabel.backgroundColor = UIColor.appColor.pomegranate
        case 6...7.99:
            voteLabel.backgroundColor = UIColor.appColor.orange
        case 8...10:
            voteLabel.backgroundColor = UIColor.appColor.nephritis
        default:
            voteLabel.backgroundColor = UIColor.clear
            voteLabel.text = ""
        }
    }
    
    // MARK: - Private  Functions
    
    private func setupViews() {
        backgroundColor = UIColor.clear
        accessoryType = .disclosureIndicator
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-20)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        voteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

}
