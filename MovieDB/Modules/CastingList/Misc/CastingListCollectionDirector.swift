//
//  CastingListCollectionDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit


protocol CastingListCollectionDirector {
    
    /// A function that updates data in a collection based on a list of models
    ///
    /// - parameter viewModel: viewModel with casting list data
    /// - parameter collectionView: collection where data will be displayed
    func update(with viewModel: CastingListViewModel)
    
}

class CastingListDefaultCollectionDirector: NSObject, CastingListCollectionDirector {
    
    private var viewModel: CastingListViewModel!
    private var collectionView: UICollectionView!
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public func update(with viewModel: CastingListViewModel) {
        self.viewModel = viewModel
        configureCollectionView()
    }
    
}

extension CastingListDefaultCollectionDirector {
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 1,
                                                   left: 1,
                                                   bottom: 1,
                                                   right: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CastCollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension CastingListDefaultCollectionDirector: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.castViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        // Configure cell
        if let castCell = cell as? CastCollectionViewCell,
            let castViewModel = viewModel.castViewModels[safe: indexPath.row] {
            
            let configuration = CastCellConfiguration()
            let font = UIFont.systemFont(ofSize: 14)
            configuration.characterFont = font
            configuration.nameFont = font
            castViewModel.configuration = configuration
        
            castCell.configure(castViewModel)
        }
        return cell
    }
    
}

extension CastingListDefaultCollectionDirector: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 200
    }
    
}
