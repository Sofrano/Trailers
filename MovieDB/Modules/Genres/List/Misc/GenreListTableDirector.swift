//
//  GenreListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

// due to the fact that I chose a library to work with the table - it limited me
// to some conventions, because of this, the code below on updating cells looks awful

protocol GenreListTableDirector {
    func update(with viewModel: GenreListViewModel)
}

class GenreListDefaultTableDirector: GenreListTableDirector {
    
    private var viewModel: GenreListViewModel!
    private var tableKit: TableDirector!
    
    init(tableView: UITableView) {
        self.tableKit = TableDirector(tableView: tableView)
    }
    
    public func update(with viewModel: GenreListViewModel) {
        self.viewModel = viewModel
        updateRows()
    }
    
}

extension GenreListDefaultTableDirector {
    
    private func updateRows() {
        updatePosterRows()
        updateDescriptionRows()
    }
    
    private func updatePosterRows() {
        guard tableKit.sections.count == 0 else { return }
        tableKit.clear()
        let section = TableSection(rows: [])
        section.headerHeight = 0.1 
        let posterRow = TableRow<PagerTableViewCell>(item: viewModel.imageCollectionViewModel)
        section.append(row: posterRow)
        tableKit.append(section: section)
        tableKit.reload()
    }
    
    private func updateDescriptionRows() {
        
        // IndexPathes for reloading rows
        var indexPathes: [IndexPath] = []
        guard let tableView = tableKit.tableView,
            let section = tableKit.sections.first else { return }
        
        if let movieShortDescritpionViewModel = viewModel.movieShortDescriptionViewModel {
            let titleRow = TableRow<MovieShortDescriptionTableViewCell>(item: movieShortDescritpionViewModel)
                .on(.click) { _ in
                    movieShortDescritpionViewModel.invoke(action: .click)
            }
            
            // If the title cell in the table already exist, then you need to reload it, otherwise add to the table
            if tableView.cellForRow(at: IndexPath(item: 1, section: 0)) != nil {
                section.replace(rowAt: 1, with: titleRow)
                indexPathes.append(IndexPath(row: 1, section: 0))
            } else {
                section.append(row: titleRow)
            }
        }
        if let textViewModel = viewModel.textViewModel {
            let overviewRow = TableRow<TextTableViewCell>(item: textViewModel)
                .on(.configure) { options in
                    guard let cell = options.cell else { return }
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            
            // If the overview cell in the table already exist, then you need to reload it, otherwise add to the table
            if tableView.cellForRow(at: IndexPath(item: 2, section: 0)) != nil {
                section.replace(rowAt: 2, with: overviewRow)
                indexPathes.append(IndexPath(row: 2, section: 0))
            } else {
                section.append(row: overviewRow)
            }
        }

        // Determine exactly how to update the table. If cells already were, then reload
        if tableView.numberOfRows(inSection: 0) >= 3 {
            tableView.reloadRows(at: indexPathes, with: .fade)
        } else {
            tableKit.reload()
        }

    }
    
}
