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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    // MARK: - Variables
    
    var output: TextListViewOutput?
    private lazy var tableDirector: TextListTableDirector = TextListDefaultTableDirector(tableView: self.tableView)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    // MARK: - Private functions
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
}

extension TextListViewController: TextListViewInput {
    
    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
        setupConstraints()
    }
    
    func update(with viewModel: TextListViewModel) {
        tableDirector.update(with: viewModel)
    }
    
}
