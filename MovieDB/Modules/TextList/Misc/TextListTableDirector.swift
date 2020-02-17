//
//  TextListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

protocol TextListTableDirector {
    
    func update(with viewModel: TextListViewModel)
    
}

class TextListDefaultTableDirector: TextListTableDirector {
    
    private var viewModel: TextListViewModel!
    private var tableKit: TableDirector!
    
    init(tableView: UITableView) {
        tableKit = TableDirector(tableView: tableView)
    }
    
    public func update(with viewModel: TextListViewModel) {
        self.viewModel = viewModel
        updateTableView()
    }
    
}

extension TextListDefaultTableDirector {
    
    private func updateTableView() {
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
