//
//  PosterPagerPosterPagerTableViewCell.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Carousel with posters

import Foundation
import TableKit
import FSPagerView
import Kingfisher

struct PosterPagerCellActions {
    static let ChangePage = "changePage"
}

class PagerTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Private Variables
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.delegate = self
        pagerView.dataSource = self
        contentView.addSubview(pagerView)
        return pagerView
    }()
    
    private var viewModel: ImageCollectionViewModel?
    private var configuration: PagerCellConfiguration?
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - ConfigurableCell Protocol
    
    func configure(with data: ImageCollectionViewModel) {
        self.viewModel = data
        self.configuration = data.configuration as? PagerCellConfiguration
        if let configuration = self.configuration  {
            configuration.onConfigureView(self)
            setupPagerView(transform: configuration.transform,
                           transformerType: configuration.transformerType,
                           height: configuration.height,
                           slidingInterval: configuration.slidingInterval)
        }
    }
    
    /**
     This function allows you to customize the display of content in the cell.
     
     - Parameter transform: transformation of an existing height and width.
     - Parameter transformerType: enum crossFading, zoomOut, depth, overlap, linear, coverFlow, ferrisWheel, invertedFerrisWheel, cubic
     - Parameter height: height of cell
     - Parameter slidingInterval: The time interval of automatic sliding. 0 means disabling automatic sliding. Default is 0.
    */
    
    private func setupPagerView(transform: CGAffineTransform = CGAffineTransform(scaleX: 0.6, y: 0.75),
                               transformerType: FSPagerViewTransformerType = .linear,
                               height: CGFloat = 380,
                               slidingInterval: CGFloat? = nil) {
        pagerView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        pagerView.itemSize = CGSize(width: self.frame.width, height: height).applying(transform)
        pagerView.decelerationDistance = 1
        if let interval = slidingInterval {
            pagerView.automaticSlidingInterval = interval
        }
        pagerView.transformer = FSPagerViewTransformer(type: transformerType)
    }

    // MARK: - Private Functions
    
    private func setupViews() {
        self.backgroundColor = UIColor.clear
    }
    
    private func setupConstraints() {
        pagerView.snp.makeConstraints { (make) in
            make.height.equalTo(380)
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
        }
        setupPagerView()
    }
    
}

extension PagerTableViewCell: FSPagerViewDelegate {
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        viewModel?.invoke(action: .selectItem(index: targetIndex))
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
}

extension PagerTableViewCell: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel?.URLs.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = viewModel?.URLs[index]
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.kf.indicatorType = .activity
        (cell.imageView?.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
}

