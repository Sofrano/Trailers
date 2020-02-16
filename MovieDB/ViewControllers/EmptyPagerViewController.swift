//
//  EmptyPagerViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

protocol XLPagerPage: UIViewController, IndicatorInfoProvider {}
extension XLPagerPage {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title?.uppercaseFirstLetter() ?? "Unknown")
    }
    
}

// XLPagerTabStrip requires at least one controller, this is an empty controller,
// which is displayed when loading the list of pages
class EmptyPagerViewController: UIViewController, XLPagerPage {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // do nothing
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title ?? "")
    }
}
