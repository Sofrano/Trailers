//
//  ButtonBarPagerTabStripViewController+Ext.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 22/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import XLPagerTabStrip

extension ButtonBarPagerTabStripViewController {
    
    func setupDefaultStyle() {
        settings.style.buttonBarBackgroundColor = UIColor.appColor.behance
        settings.style.buttonBarItemBackgroundColor = UIColor.appColor.behance
        settings.style.selectedBarBackgroundColor = UIColor.appColor.orange
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.appColor.silver
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
    }
    
}
