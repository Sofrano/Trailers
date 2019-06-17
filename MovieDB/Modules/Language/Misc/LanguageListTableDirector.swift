//
//  LanguageTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

class LanguageListTableDirector {
    
    fileprivate var viewModel: LanguageListViewModel!
    fileprivate var tableKit: TableDirector!
    
    public func update(with viewModel: LanguageListViewModel,
                       tableView: UITableView) {
        self.viewModel = viewModel
        if tableKit == nil {
            self.tableKit = TableDirector(tableView: tableView)
        }
        configureTableView()
    }
    
    fileprivate func configureTableView() {}
    
}

class LanguageListDefaultTableDirector: LanguageListTableDirector {
    
    fileprivate override func configureTableView() {
        tableKit.clear()
        let section = TableSection(rows: [])
        section.headerHeight = 0.1
        viewModel.languages.forEach { (languageViewModel) in
            let row = TableRow<LanguageTableViewCell>(item: languageViewModel)
                .on(.click) { _ in
                    let index = self.viewModel.languages.firstIndex { $0.text == languageViewModel.text }
                    if let index = index {
                        self.viewModel.onSelectLanguage(index)
                    }
                }
            section.append(row: row)
        }
        tableKit.append(section: section)
        tableKit.reload()
    }
}
