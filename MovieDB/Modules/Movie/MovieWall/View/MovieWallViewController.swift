//
//  MovieWallMovieWallViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
import FSPagerView
import XLPagerTabStrip
import PhotoSlider

class MovieWallViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Variables
    
    var output: MovieWallViewOutput?
    var tableDirector = MovieWallDefaultTableDirector()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
}

extension MovieWallViewController: MovieWallViewInput {
    
    func setupInitialState() {
        tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.appColor.behance
    }
    
    func update(with viewModel: MovieWallViewModel) {
        tableDirector.update(with: viewModel,
                             tableView: tableView)
    }
    
}
