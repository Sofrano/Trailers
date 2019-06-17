//
//  ImageListImageListViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
import Foundation
import XLPagerTabStrip

class ImageListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private var tableDirector = ImageListDefaultTableDirector()
    var output: ImageListViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

}

extension ImageListViewController: ImageListViewInput {
    
    func update(with viewModel: ImageListViewModel) {
        tableDirector.update(with: viewModel, tableView: tableView)
    }

    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
    }

}
