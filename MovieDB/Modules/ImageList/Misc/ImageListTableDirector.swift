//
//  ImageListTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

protocol ImageListTableDirector {

    func update(with viewModel: ImageListViewModel)
    
}

class ImageListDefaultTableDirector: ImageListTableDirector {
    
    private var viewModel: ImageListViewModel!
    private var tableKit: TableDirector!
    
    init(tableView: UITableView) {
        self.tableKit = TableDirector(tableView: tableView)
    }
    
    public func update(with viewModel: ImageListViewModel) {
        self.viewModel = viewModel
        updateTableView()
    }
    
}

extension ImageListDefaultTableDirector {
    
    private func updateTableView() {
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
