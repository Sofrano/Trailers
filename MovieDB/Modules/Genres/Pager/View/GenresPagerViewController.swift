//
//  GenresPagerGenresPagerViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Genres Pager

import UIKit
import XLPagerTabStrip


class GenresPagerViewController: ButtonBarPagerTabStripViewController {

    // MARK: - Variables
    
    // Page array. The library forces to create at least one page.
    // EmptyPagerViewController = stub
    private var pages: [XLPagerPage] = [EmptyPagerViewController()]
    var output: GenresPagerViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        configurePager()
        super.viewDidLoad()
        title = "Trailers"
        output?.viewIsReady()
    }

    // MARK: - Private functions

    private func configurePager() {
        // UI pager settings
        setupDefaultStyle()
        
        // Change the colors of pager titles depending on the selected
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?,
            progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.appColor.silver
            newCell?.label.textColor = UIColor.white
        }
    }
    
    // PagerTabStripViewController Delegate
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return pages
    }

}

extension GenresPagerViewController: GenresPagerViewInput {

    func setupInitialState() {
        containerView.backgroundColor = UIColor.appColor.behance
        containerView.bounces = false
    }
    
    func update(withPages pages: [XLPagerPage]) {
        self.pages = pages
        reloadPagerTabStripView()
    }
    
}


