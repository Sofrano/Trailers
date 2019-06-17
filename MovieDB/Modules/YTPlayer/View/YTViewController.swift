//
//  YTYTViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import SnapKit
import SVProgressHUD

class YTViewController: UIViewController {
    
    // MARK: - Variables
    
    var playerView: YTPlayerView!
    var output: YTViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    // MARK: - Private functions

    private func setupPlayer() {
        playerView = YTPlayerView(frame: self.view.frame)
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
        }
        playerView.delegate = self
        self.view.addSubview(playerView)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(exit),
                                               name: UIWindow.didBecomeHiddenNotification,
                                               object: nil)
    }
    
}

extension YTViewController: YTViewInput {

    func setupInitialState() {
        self.view.backgroundColor = UIColor.black
        setupPlayer()
        setupObservers()
    }
    
    func playVideo(id: String) {
        playerView.load(withVideoId: id)
    }
    
}

extension YTViewController {
    
    // Called when finished viewing video
    @objc func exit() {
        output?.close()
    }
    
}

extension YTViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        SVProgressHUD.dismiss()
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        showAlert(withMessage: R.string.localizable.errorUnknown())
        self.navigationController?.popViewController(animated: true)
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.appColor.behance
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .ended {
            output?.close()
        }
    }
    
}
