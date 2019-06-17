//
//  CastingListCollectionDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

class CastingListCollectionDirector: NSObject {
    
    fileprivate var viewModel: CastingListViewModel!
    fileprivate var collectionView: UICollectionView!
    
    public func update(with viewModel: CastingListViewModel,
                       collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        configureCollectionView()
    }
    
    fileprivate func configureCollectionView() {}
    
}

class CastingListDefaultCollectionDirector: CastingListCollectionDirector {
    
    fileprivate override func configureCollectionView() {
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension CastingListDefaultCollectionDirector: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.castViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 200
    }
    
}
