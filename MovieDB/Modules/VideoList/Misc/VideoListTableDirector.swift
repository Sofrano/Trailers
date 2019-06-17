//
//  VideoListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

class VideoListTableDirector {
    
    fileprivate var viewModel: VideoListViewModel!
    fileprivate var tableKit: TableDirector!
    
    public func update(with viewModel: VideoListViewModel,
                       tableView: UITableView) {
        self.viewModel = viewModel
        if tableKit == nil {
            self.tableKit = TableDirector(tableView: tableView)
        }
        configureTableView()
    }
    
    fileprivate func configureTableView() {}
    
}

class VideoListDefaultTableDirector: VideoListTableDirector {
    
    fileprivate override func configureTableView() {
        tableKit.clear()
        let section = TableSection(rows: [])
        viewModel.listViewModel.forEach { (ytViewModel) in
            let row = TableRow<YTPlayerTableViewCell>(item: ytViewModel)
                .on(.click) { _ in
                    ytViewModel.invoke(action: .click)
            }
            section.append(row: row)
        }
        tableKit.append(section: section)
        tableKit.reload()
    }
}
