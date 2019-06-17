//
//  ImageListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

class ImageListTableDirector {
    
    fileprivate var viewModel: ImageListViewModel!
    fileprivate var tableKit: TableDirector!
    
    public func update(with viewModel: ImageListViewModel,
                       tableView: UITableView) {
        self.viewModel = viewModel
        if tableKit == nil {
            self.tableKit = TableDirector(tableView: tableView)
        }
        configureTableView()
    }
    
    fileprivate func configureTableView() {}
    
}

class ImageListDefaultTableDirector: ImageListTableDirector {
    
    fileprivate override func configureTableView() {
        tableKit.clear()
        let section = TableSection(rows: [])
        viewModel.imagesViewModel.forEach { (imageViewModel) in
            let imageRow = TableRow<ImageTableViewCell>(item: imageViewModel)
                .on(.click) { options in
                    imageViewModel.invoke(action: .click(rowIndex: options.indexPath.row))
            }
            section.append(row: imageRow)
        }
        tableKit.append(section: section)
        tableKit.reload()
    }
}
