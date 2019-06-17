//
//  GenreListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

class GenreListTableDirector {
    
    fileprivate var viewModel: GenreListViewModel!
    fileprivate var tableKit: TableDirector!
    
    public func update(with viewModel: GenreListViewModel,
                       tableView: UITableView) {
        self.viewModel = viewModel
        if tableKit == nil {
            self.tableKit = TableDirector(tableView: tableView)
        }
        configureTableView()
    }
    
    fileprivate func configureTableView() {}
    
}

class GenreListDefaultTableDirector: GenreListTableDirector {
    
    fileprivate override func configureTableView() {
        setupPosterRows()
        setupDescriptionRows()
    }
    
    private func setupPosterRows() {
        guard tableKit.sections.count == 0 else { return }
        tableKit.clear()
        let section = TableSection(rows: [])
        section.headerHeight = 0.1
        let posterRow = TableRow<PagerTableViewCell>(item: viewModel.imageCollectionViewModel)
        section.append(row: posterRow)
        tableKit.append(section: section)
        tableKit.reload()
    }
    
    private func setupDescriptionRows() {
        
        // IndexPathes for reloading rows
        var indexPathes: [IndexPath] = []
        guard let tableView = tableKit.tableView,
            let section = tableKit.sections.first else { return }
        
        if let movieShortDescritpionViewModel = viewModel.movieShortDescriptionViewModel {
            let titleRow = TableRow<MovieShortDescriptionTableViewCell>(item: movieShortDescritpionViewModel)
                .on(.click) { _ in
                    movieShortDescritpionViewModel.invoke(action: .click)
                    //guard let media = self.currentMedia else {
                    //    return
                    //}
                    //self.output?.openMedia(media)
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
                    if let cell = options.cell {
                        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
                    }
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
    
    private func configureObserveViewModel() {
//        viewModel.currentPosterIndex?.asObservable().subscribe(onNext: { (value) in
//
//        })
//        .disposed(by: disposeBag)
    }
    
    
    /*
    func appendOrReloadVideoContent() {
        if let media = currentMedia {
            if let section = tableKit.sections.first {
                
                // Cell with movie title, genre and rating
                let titleRow = TableRow<MovieShortDescriptionTableViewCell>(item: media)
                    .on(.click) { _ in
                        guard let media = self.currentMedia else {
                            return
                        }
                        self.output?.openMedia(media)
                }
                // Film description box
                let overviewRow = TableRow<TextTableViewCell>(item: media.overview ?? "")
                    .on(.configure) { options in
                        if let cell = options.cell {
                            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
                        }
                }
                
                // IndexPathes for reloading rows
                var indexPathes: [IndexPath] = []
                
                // If the title cell in the table already exist, then you need to reload it, otherwise add to the table
                if tableView.cellForRow(at: IndexPath(item: 1, section: 0)) != nil {
                    section.replace(rowAt: 1, with: titleRow)
                    indexPathes.append(IndexPath(row: 1, section: 0))
                } else {
                    section.append(row: titleRow)
                }
                
                // If the overview cell in the table already exist, then you need to reload it, otherwise add to the table
                if tableView.cellForRow(at: IndexPath(item: 2, section: 0)) != nil {
                    section.replace(rowAt: 2, with: overviewRow)
                    indexPathes.append(IndexPath(row: 2, section: 0))
                } else {
                    section.append(row: overviewRow)
                }
                
                // Determine exactly how to update the table. If cells already were, then reload
                if tableView.numberOfRows(inSection: 0) >= 3 {
                    tableView.reloadRows(at: indexPathes, with: .fade)
                } else {
                    tableKit.reload()
                }
            }
        }
        */
}
