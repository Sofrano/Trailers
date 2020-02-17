//
//  EntryPointEntryPointViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  List of languages

import UIKit

class LanguageViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var tableDirector: LanguageListTableDirector = LanguageListDefaultTableDirector(tableView: self.tableView)
    var output: LanguageViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

}

extension LanguageViewController: LanguageViewInput {
    
    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
    }
    
    func update(with viewModel: LanguageListViewModel) {
        tableDirector.update(with: viewModel)
    }
    
}

extension LanguageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.search(searchBar.text)
    }
    
}
