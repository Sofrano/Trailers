//
//  CastingListCastingListViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CastingListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    
    private var castings: [DTOCast] = []
    var output: CastingListViewOutput?
    private var collectionDirector = CastingListDefaultCollectionDirector()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        self.title = "Casting"
    }

}

extension CastingListViewController: CastingListViewInput {

    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
    }
    
    func update(with casts: [DTOCast]) {
        self.castings = casts
        collectionView.reloadData()
    }
    
    func update(with viewModel: CastingListViewModel) {
        collectionDirector.update(with: viewModel, collectionView: self.collectionView)
    }
    
}

