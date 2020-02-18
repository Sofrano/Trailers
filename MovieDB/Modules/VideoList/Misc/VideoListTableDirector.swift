//
//  VideoListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

protocol VideoListTableDirector {
    
    func update(with viewModel: VideoListViewModel)
    
}

class VideoListDefaultTableDirector: VideoListTableDirector {
    
    private var viewModel: VideoListViewModel!
    private var tableKit: TableDirector!
    
    init(tableView: UITableView) {
        tableKit = TableDirector(tableView: tableView)
    }
    
    public func update(with viewModel: VideoListViewModel) {
        self.viewModel = viewModel
        updateTableView()
    }
    
}

extension VideoListDefaultTableDirector {
    
    private func updateTableView() {
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
