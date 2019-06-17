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
import LightRoute

class GenresPagerViewController: ButtonBarPagerTabStripViewController {

    // MARK: - Variables
    
    // Page array. The library forces to create at least one page.
    // EmptyPagerViewController = stub
    
    private var pages: [UIViewController] = [EmptyPagerViewController()]
    var output: GenresPagerViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        configurePager()
        super.viewDidLoad()
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
        self.title = "Trailers"
        containerView.backgroundColor = UIColor.appColor.behance
        containerView.bounces = false
    }
    
    // Received data from the presenter
    // We create pages on the basis of the obtained data
    func update(with genres: [DTOGenre]) {
        pages = []
        genres.forEach { (genre) in
            try? forStoryboard(factory: R.storyboard.genreListView().factory,
                               to: GenreListModuleInput.self)
                .to(preferred: TransitionStyle.split(style: .default))
                .apply(to: { (viewController) in
                    viewController.title = genre.name 
                    self.pages.append(viewController)
                })
                .then({ (moduleInput) -> Any? in
                    moduleInput.configure(with: genre)
                })
        }
        reloadPagerTabStripView()
    }
    
}


