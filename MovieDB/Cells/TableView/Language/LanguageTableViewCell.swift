//
//  LanguageLanguageTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Language Item 

import Foundation
import TableKit

class LanguageTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    // MARK: - Variables
    
    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: TextCellViewModel) {
        titleLabel.text  = data.text
        selectedBackgroundView = selectionView
    }
    
}
