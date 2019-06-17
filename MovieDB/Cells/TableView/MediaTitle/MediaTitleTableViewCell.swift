//
//  MovieHeaderMovieHeaderTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Cell with a summary of the film. Used in header wall under the poster
//  Upper Label lick out of borders to be displayed on the poster

import Foundation
import TableKit
import SnapKit
import FSPagerView

class MediaTitleTableViewCell: UITableViewCell, ConfigurableCell {

    // MARK: - Variables
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        return stackView
    }()
    
    private var viewModel: MediaTitleViewModel?
    
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
    
    func configure(with data: MediaTitleViewModel) {
        self.viewModel = data
        titleLabel.text = viewModel?.title
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for line in viewModel?.lines ?? [] {
            let label = UILabel()
            label.textColor = UIColor.lightGray
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = line
            stackView.addArrangedSubview(label)
        }
        viewModel?.configuration?.onConfigureView(self)
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
            make.top.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
}
