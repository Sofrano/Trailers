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

    var output: CastingListViewOutput?
    private var collectionDirector: CastingListCollectionDirector = CastingListDefaultCollectionDirector()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Casting"
        output?.viewIsReady()
    }

}

extension CastingListViewController: CastingListViewInput {

    func setupInitialState() {
        view.backgroundColor = UIColor.appColor.behance
    }
    
    func update(with viewModel: CastingListViewModel) {
        collectionDirector.update(with: viewModel,
                                  collectionView: collectionView)
    }
    
}

