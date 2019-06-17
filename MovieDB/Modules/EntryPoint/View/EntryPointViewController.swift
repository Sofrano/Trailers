//
//  EntryPointEntryPointViewController.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Download window at the start of the application.
//  It loads data for the configurator.

import UIKit
class EntryPointViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Variables

    var output: EntryPointViewOutput?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

}

extension EntryPointViewController: EntryPointViewInput {

    func updateProgress(_ progress: Float) {
        progressView.progress = progress
    }
    
    func setupInitialState() {
        self.view.backgroundColor = UIColor.appColor.behance
    }
    
}
