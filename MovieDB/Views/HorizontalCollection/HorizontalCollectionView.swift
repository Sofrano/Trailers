//
//  HorizontalCollectionView.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 11/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

public protocol HorizontalCollectionViewDataSource: class {
    
    /// Asks your data source object for the number of items in the collection view.
    func numberOfItems(in collectionView: HorizontalCollectionView) -> Int
    
    /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
    func collectionView(_ collectionView: HorizontalCollectionView,
                        cellForItemAt index: Int) -> UICollectionViewCell
    
}

@objc
public protocol HorizontalCollectionViewDelegate: class {
    
    /// Asks your data source object for the number of items in the collection view.
    @objc optional func collectionView(_ collectionView: HorizontalCollectionView, didSelectItemAt index: Int)
    
}

public class HorizontalCollectionView: UIView {
    
    // MARK: - Variables
    
    weak var dataSource: HorizontalCollectionViewDataSource?
    weak var delegate: HorizontalCollectionViewDelegate?
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = UICollectionViewFlowLayout()
    
    /**
     Size of items in the collection.
     Default value CGSize(width: 100, height: 150)
     */
    public var itemSize: CGSize = CGSize(width: 100, height: 150) {
        didSet {
            layout.itemSize = itemSize
        }
    }
    
    /**
     Distance between items
     */
    public var interitemSpacing: CGFloat = 10 {
        didSet {
            layout.minimumInteritemSpacing = interitemSpacing
        }
    }
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Public Functions
    
    /**
     Reload collection view
     */
    public func reload() {
        collectionView.reloadData()
    }
    
    /**
     Returns a typed reusable cell object located by its identifier
     
     - parameter identifier: The R.reuseIdentifier.* value for the specified cell.
     - parameter index: The index specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index to perform additional configuration based on the cell’s position in the collection view.
     
     - returns: A subclass of HorizontalCollectionCell
     */
    public func dequeueReusableCell(withReuseIdentifier identifier: String, at index: Int) -> HorizontalCollectionCell {
        let indexPath = IndexPath(item: index, section: 0)
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard cell.isKind(of: HorizontalCollectionCell.self) else {
            fatalError("Cell class must be subclass of HorizontalCollectionCell")
        }
        return cell as! HorizontalCollectionCell
    }
    
    /**
     Register a class for use in creating new collection view cells.
    */
    public func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        addSubview(collectionView)
        
        layout.itemSize = itemSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = interitemSpacing
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        
        self.backgroundColor = UIColor.clear
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension HorizontalCollectionView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView?(self, didSelectItemAt: indexPath.row)
    }
    
}

extension HorizontalCollectionView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(in: self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.collectionView(self, cellForItemAt: indexPath.row) ?? UICollectionViewCell()
    }
    
    
}
