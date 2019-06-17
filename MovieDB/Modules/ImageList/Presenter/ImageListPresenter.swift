//
//  ImageListImageListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class ImageListPresenter: ImageListModuleInput {

    weak var view: ImageListViewInput?
    var interactor: ImageListInteractorInput?
    var router: ImageListRouterInput?
    private var posters: [DTOPoster] = []
    
    func configure(with posters: [DTOPoster]) {
        self.posters = posters
    }
    
    func createViewModel(_ posters: [DTOPoster]) -> ImageListViewModel {
        let viewModel = ImageListViewModel()
        let imageURLs = posters.map { $0.filePath?.url(size: EBackdropSize.original) }.compactMap { $0 }
        posters.forEach { (poster) in
            if let url = poster.filePath?.url(size: EBackdropSize.original) {
                let imageViewModel = ImageCellViewModel(imageURL: url,
                                                        aspectRatio: poster.aspectRatio)
                    .observeAction({ (action) in
                        switch action {
                        case .click(let index):
                            self.router?.openSlider(imageURLs: imageURLs, index: index)
                        }
                    })
                viewModel.imagesViewModel.append(imageViewModel)
            }
            
        }
        return viewModel
    }
    
}

extension ImageListPresenter: ImageListViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        let viewModel = createViewModel(posters)
        view?.update(with: viewModel)
    }
}

extension ImageListPresenter: ImageListInteractorOutput {
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
