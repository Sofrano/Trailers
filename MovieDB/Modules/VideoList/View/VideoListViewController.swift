//
//  VideoListVideoListViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import youtube_ios_player_helper

class VideoListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var tableDirector: VideoListTableDirector = VideoListDefaultTableDirector(tableView: self.tableView)
    var output: VideoListViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
}

extension VideoListViewController: VideoListViewInput {

    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
    }

    func update(with viewModel: VideoListViewModel) {
        tableDirector.update(with: viewModel)
    }
    
}

extension VideoListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title ?? R.string.localizable.video())
    }
    
}
