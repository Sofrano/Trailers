//
//  EntryPointEntryPointPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import Foundation

class LanguagePresenter {
    
    weak var view: LanguageViewInput?
    var interactor: LanguageInteractorInput?
    var router: LanguageRouterInput?
    private var languages: [DTOLanguage] = []
    private lazy var vmCreator: LanguageListViewModelCreator = LanguageListDefaultViewModelCreator(output: self)
    private var viewModel: LanguageListViewModel?
    
    private func scrollToDefaultLanguage() {
        // Determine which language to scroll user
        if let index = self.languages.firstIndex(where: {$0.iso6391 == interactor?.defaultLanguage}) {
            viewModel?.scrollToIndex?(index)
        }
    }
    
    private func presentWelcomeIfNeed() {
        // If the language is not selected, then make the user select it
        if interactor?.defaultLanguage == nil {
            router?.presentWelcome()
        }
    }
    
}

extension LanguagePresenter: LanguageModuleInput { }

extension LanguagePresenter: LanguageViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchLanguages()
    }
    
    func search(_ query: String?) {
        viewModel?.filterLanguages(with: query)
        guard let viewModel = viewModel else { return }
        view?.update(with: viewModel)
        //        let query = query ?? ""
        //        guard !query.isEmpty else {
        //            viewModel = vmCreator.createViewModel(languages: languages)
        //            view?.update(with: viewModel!)
        //            return
        //        }
        //        let uppercasedQuery = query.uppercased()
        //        let filteredLanguages = languages.filter {
        //            $0.title.uppercased().contains(uppercasedQuery) || ($0.englishName ?? "").uppercased().contains(uppercasedQuery)
        //        }
        //        let model = createViewModel(languages: filteredLanguages)
        //        view?.update(with: model)
    }
    
}

extension LanguagePresenter: LanguageListViewModelOutput {
    
    /*
     The window with the choice of language is called from two places - when the application is
     first started (the default language is not selected) and from the settings.
     If this is the first start of the application, then after selecting the
     language, open the configurator download window.
     */
    func selectLanguage(_ language: DTOLanguage) {
        let isNeedPresentEntryPoint = interactor?.userLanguage == nil
        interactor?.setLanguage(language)
        if isNeedPresentEntryPoint { router?.presentEntryPoint() }
    }
    
}

extension LanguagePresenter: LanguageInteractorOutput {
    
    func onFetchedLanguages(_ languages: [DTOLanguage]) {
        viewModel = vmCreator.createViewModel(languages: languages)
        view?.update(with: viewModel!)
        scrollToDefaultLanguage()
        presentWelcomeIfNeed()
    }
    
}
