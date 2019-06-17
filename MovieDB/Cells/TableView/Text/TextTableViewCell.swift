//
//  TextTextTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 11/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Cell with Multiline Text, using by TextListViewController

import Foundation
import TableKit

class TextTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: TextCellViewModel) {
        setupViews()
        textLabel?.text = data.text
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.textColor = UIColor.white
        textLabel?.numberOfLines = 0
    }
    
}
