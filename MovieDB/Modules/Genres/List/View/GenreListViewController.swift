//
//  GenreListGenreListViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  List of genres in the horizontal version


import UIKit
import XLPagerTabStrip
import TableKit
import SnapKit

class GenreListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: BlurImageView!
    
    // MARK: - Variables
    
    private var tableDirector = GenreListDefaultTableDirector()
    
    
    var output: GenreListViewOutput?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
}

extension GenreListViewController: GenreListViewInput {
    
    func setupInitialState() {
        self.view.backgroundColor = UIColor.clear
    }
    
    func update(with viewModel: GenreListViewModel) {
        tableDirector.update(with: viewModel, tableView: tableView)
        if let index = viewModel.currentPosterIndex {
            let imageURL = viewModel.imageCollectionViewModel.URLs[index]
            self.backgroundImageView.kf.setImage(with: imageURL)
        }
    }
    
    
}
extension GenreListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title?.uppercaseFirstLetter() ?? "Unknown")
    }
    
}
