//
//  TextListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

class TextListTableDirector {
    
    fileprivate var viewModel: TextListViewModel!
    fileprivate var tableKit: TableDirector!
    
    public func update(with viewModel: TextListViewModel,
                       tableView: UITableView) {
        self.viewModel = viewModel
        if tableKit == nil {
            self.tableKit = TableDirector(tableView: tableView)
        }
        configureTableView()
    }
    
    fileprivate func configureTableView() {}
    
}

class TextListDefaultTableDirector: TextListTableDirector {
    
    fileprivate override func configureTableView() {
        tableKit.clear()
        let section = TableSection(rows: [])
        section.headerHeight = 0.1
        viewModel.textList.forEach { (text) in
            let model = TextCellViewModel(text: text)
            let row = TableRow<TextTableViewCell>(item: model)
            section.append(row: row)
        }
        tableKit.append(section: section)
        tableKit.reload()
    }
}
