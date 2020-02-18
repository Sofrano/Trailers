//
//  YTYTPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class

class YTPresenter {

    weak var view: YTViewInput?
    var interactor: YTInteractorInput?
    var router: YTRouterInput?
    
    private var videoId: YTVideoID?
    
}

// MARK: - Module Input

extension YTPresenter: YTModuleInput {
    
    func configure(with videoId: YTVideoID) {
        self.videoId = videoId
    }
 
}

// MARK: - View Output

extension YTPresenter: YTViewOutput {

    func close() {
        router?.popViewController()
    }
    
    func viewIsReady() {
        view?.setupInitialState()
        view?.playVideo(id: videoId ?? "")
    }
    
}

// MARK: - Interactor Output

extension YTPresenter: YTInteractorOutput {}
