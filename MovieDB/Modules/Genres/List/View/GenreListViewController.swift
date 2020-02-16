//
//  GenreListViewController.swift
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

class GenreListViewController: UIViewController, XLPagerPage {
    
    // MARK: - UI lazy variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var backgroundImageView: BlurImageView = {
        let imageView = BlurImageView(frame: .zero)
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        return imageView
    }()
    
    // MARK: - Variables
    
    var output: GenreListViewOutput?
    private lazy var tableDirector: GenreListTableDirector = GenreListDefaultTableDirector(tableView: self.tableView)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    // MARK: - Private functions
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
    }
    
}

extension GenreListViewController: GenreListViewInput {
    
    func setupInitialState() {
        setupConstraints()
        self.view.backgroundColor = UIColor.clear
    }
    
    func update(with viewModel: GenreListViewModel) {
        tableDirector.update(with: viewModel)
        // if there is data about the selected poster,
        // then lay down the background
        if let index = viewModel.currentPosterIndex {
            let imageURL = viewModel.imageCollectionViewModel.URLs[index]
            self.backgroundImageView.kf.setImage(with: imageURL)
        }
    }
    
}
