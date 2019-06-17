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
    
    private var tableDirector = VideoListDefaultTableDirector()
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
        tableDirector.update(with: viewModel, tableView: tableView)
    }
    
    func update(with videos: [DTOVideo]) {
        /*tableKit.clear()
        let section = TableSection(rows: [])
        videos.forEach { (video) in
            let row = TableRow<YTPlayerTableViewCell>(item: video)
                .on(.click) { _ in
                    self.output?.openVideo(video)
            }
            section.append(row: row)
        }
        tableKit.append(section: section)
        tableKit.reload()*/
    }
    
}

extension VideoListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title ?? R.string.localizable.video())
    }
    
}
