//
//  ImageListImageListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class
import Foundation
class ImageListPresenter {

    weak var view: ImageListViewInput?
    var interactor: ImageListInteractorInput?
    var router: ImageListRouterInput?
    
    private lazy var vmCreator: ImageListViewModelCreator = ImageListDefaultViewModelCreator(output: self)
    private var posters: [DTOPoster] = []
    private var imageURLs: [URL] = []
    
}

// MARK: - Module Input

extension ImageListPresenter: ImageListModuleInput {
    
    func configure(with posters: [DTOPoster]) {
        self.posters = posters
        imageURLs = posters.map { $0.filePath?.url(size: EBackdropSize.original) }.compactMap { $0 }
    }
    
}

// MARK: - View Output

extension ImageListPresenter: ImageListViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        let viewModel = vmCreator.createViewModel(posters)
        view?.update(with: viewModel)
    }
}

// MARK: - ViewModel Output

extension ImageListPresenter: ImageListViewModelOutput {
  
    func imageClick(atIndex: Int) {
        router?.presentSlider(imageURLs: imageURLs,
                              scrollToIndex: atIndex)
    }

}

// MARK: - Interactor Output

extension ImageListPresenter: ImageListInteractorOutput {}
