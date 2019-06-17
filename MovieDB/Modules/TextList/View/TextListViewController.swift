//
//  TextListTextListViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit

class TextListViewController: UIViewController {

    // MARK: - IBOutlets
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Variables

    var output: TextListViewOutput?
    var tableDirector = TextListDefaultTableDirector()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    // MARK: - Private functions

    private func setupTable() {
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

}

extension TextListViewController: TextListViewInput {

    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
        setupTable()
    }
    
    func update(with viewModel: TextListViewModel) {
        tableDirector.update(with: viewModel, tableView: tableView)
    }
}
