//
//  EntryPointEntryPointPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import Foundation

class LanguagePresenter: LanguageModuleInput {

    weak var view: LanguageViewInput?
    var interactor: LanguageInteractorInput?
    var router: LanguageRouterInput?
    private var languages: [DTOLanguage] = []
    
    func viewIsReady() {
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchLanguages()
    }
    
    func createViewModel(languages: [DTOLanguage]) -> LanguageListViewModel {
        let langViewModels = languages.map { TextCellViewModel(text: $0.title) }
        let viewModel = LanguageListViewModel(languages: langViewModels)
        viewModel.onSelectLanguage = { index in
            if let language = languages[safe: index] {
                self.selectLanguage(language)
            }
        }
        return viewModel
    }
}

extension LanguagePresenter: LanguageViewOutput {

    func search(_ query: String) {
        guard !query.isEmpty else {
            let model = createViewModel(languages: self.languages)
            view?.update(with: model)
            return
        }
        let uppercasedQuery = query.uppercased()
        let filteredLanguages = languages.filter {
            $0.title.uppercased().contains(uppercasedQuery) || ($0.englishName ?? "").uppercased().contains(uppercasedQuery)
        }
        let model = createViewModel(languages: filteredLanguages)
        view?.update(with: model)
    }
    
    func selectLanguage(_ language: DTOLanguage) {
        /* The window with the choice of language is called from two places - when the application is
         first started (the default language is not selected) and from the settings.
         If this is the first start of the application, then after selecting the
         language, open the configurator download window.
         */
        let isNeedOpenEntryPoint = RSettings.language == nil
        RSettings.language = language.iso6391 ?? "en"
        if isNeedOpenEntryPoint {
            router?.openEntryPoint()
        }
    }
    
}

extension LanguagePresenter: LanguageInteractorOutput {
    
    func onFetchedLanguages(_ languages: [DTOLanguage]) {
        // Delete language in the list that is “unknown”
        self.languages = languages.filter { $0.iso6391 != "xx" }
        view?.update(with: createViewModel(languages: self.languages))
        
        // Scroll to the system language or previously selected
        if let index = self.languages.firstIndex(where: {$0.iso6391 == RSettings.language ?? NSLocale.current.languageCode} ) {
            view?.scrollToIndex(index)
        }
        
        // If the first start of the application, then we show a message with a greeting
        if RSettings.language == nil {
            router?.showWelcomeMessage()
        }
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
