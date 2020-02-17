//
//  LanguageTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

protocol LanguageListTableDirector {
    
    func update(with viewModel: LanguageListViewModel)
    
}

class LanguageListDefaultTableDirector: LanguageListTableDirector {
    
    private var viewModel: LanguageListViewModel!
    private var tableKit: TableDirector!
    
    init(tableView: UITableView) {
        tableKit = TableDirector(tableView: tableView)
    }
    
    func update(with viewModel: LanguageListViewModel) {
        self.viewModel = viewModel
        setupBindings()
        updateTableView()
    }
    
}

extension LanguageListDefaultTableDirector {
    
    private func setupBindings() {
        // Used by presenter search
        // Scroll to the cell in which the found language
        viewModel.scrollToIndex = { [weak self] index in
            guard let self = self,
                let tableView = self.tableKit.tableView else { return }
            let indexPath = IndexPath(row: index, section: 0)
            tableView.selectRow(at: indexPath,
                                animated: true,
                                scrollPosition: .middle)
        }
    }
    
    private func updateTableView() {
        tableKit.clear()
        let section = TableSection(rows: [])
        section.headerHeight = 0.1
        viewModel.languages.forEach { (languageViewModel) in
            let row = TableRow<LanguageTableViewCell>(item: languageViewModel)
                .on(.click) { [weak self] _ in
                    guard let self = self else { return }
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
