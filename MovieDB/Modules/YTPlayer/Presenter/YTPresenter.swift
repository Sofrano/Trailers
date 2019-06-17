//
//  YTYTPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class YTPresenter: YTModuleInput {

    weak var view: YTViewInput?
    var interactor: YTInteractorInput?
    var router: YTRouterInput?
    
    private var videoId: YTVideoID?
    
    func configure(with videoId: YTVideoID) {
        self.videoId = videoId
    }
}

extension YTPresenter: YTViewOutput {

    func close() {
        router?.popViewController()
    }
    
    func viewIsReady() {
        view?.setupInitialState()
        view?.playVideo(id: videoId ?? "")
    }
    
}

extension YTPresenter: YTInteractorOutput {
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
