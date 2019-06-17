//
//  LanguagePresenterTests.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import XCTest
import UIKit
@testable import MovieDB

class LanguagePresenterTests: XCTestCase {

    var presenter = LanguagePresenter()
    var interactor = MockLanguageInteractor()
    var view = MockLanguageView()
    var router = MockLanguageRouter()
    
    var languages: [DTOLanguage] = []
    var currentLanguage = RSettings.language
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        let languageXX = DTOLanguage(iso6391: "xx",
                                     englishName: "No Language",
                                     name: "No Language")
        let languageEn = DTOLanguage(iso6391: "en",
                                     englishName: "English",
                                     name: "English")
        let languageKz = DTOLanguage(iso6391: "kz",
                                         englishName: "Kazakh",
                                         name: "kz")
        let languageRu = DTOLanguage(iso6391: "ru",
                                     englishName: "Russian",
                                     name: "Русский")
        languages = [languageXX, languageEn, languageKz, languageRu]
    }

    override func tearDown() {
        super.tearDown()
        RSettings.language = currentLanguage
    }
    
    func testSearchLanguageInPresenter() {
        presenter.onFetchedLanguages(languages)
        presenter.search("Русский")
        var countLanguages = view.viewModel?.languages.count ?? 0
        var langName = view.viewModel?.languages.first?.text
        XCTAssertTrue(countLanguages == 1 && langName == "Русский")
        presenter.search("русски")
        langName = view.viewModel?.languages.first?.text
        countLanguages = view.viewModel?.languages.count ?? 0
        XCTAssertTrue(countLanguages == 1 && langName == "Русский")
        presenter.search("russian")
        countLanguages = view.viewModel?.languages.count ?? 0
        langName = view.viewModel?.languages.first?.text
        XCTAssertTrue(countLanguages == 1 && langName == "Русский")
        presenter.search("abrakadbra")
        countLanguages = view.viewModel?.languages.count ?? 0
        langName = view.viewModel?.languages.first?.text
        XCTAssertTrue(countLanguages == 0)
    }
    
    func testSelectLanguage() {
        RSettings.language = ELanguage.en.languageIdentifier
        guard let language = languages.last else {
            return
        }
        presenter.selectLanguage(language)
        XCTAssertTrue(RSettings.language == ELanguage.ru.languageIdentifier)
    }
    
    func testFetchLanguagesInInteractor() {
        presenter.viewIsReady()
        XCTAssertTrue(interactor.fetchLanguagesCalled, "should call fetchLanguages")
    }
    
    func testSetupInitialStateInView() {
        presenter.viewIsReady()
        XCTAssertTrue(view.setupInitialStateCalled, "should call InitialStateInView")
    }
    
    func testScrollToIndexOfLanguageInView() {
        RSettings.language = ELanguage.en.languageIdentifier
        presenter.onFetchedLanguages(languages)
        XCTAssert(view.scrollToIndex == 0)
        RSettings.language = ELanguage.ru.languageIdentifier
        presenter.onFetchedLanguages(languages)
        XCTAssert(view.scrollToIndex == 2)
    }
    
    func testOpenEntryPoint() {
        presenter.selectLanguage(DTOLanguage(iso6391: "test", englishName: "test", name: "test"))
        XCTAssertTrue(RSettings.language == "test")
        XCTAssertTrue(router.openEntryPointCalled)
        RSettings.language = nil
    }
    
    func testShowWelcomeMessageInView() {
        RSettings.language = nil
        presenter.onFetchedLanguages(languages)
        XCTAssertTrue(router.showWelcomeMessageCalled)
    }
    
    func testUpdateInView() {
        RSettings.language = ELanguage.en.languageIdentifier
        presenter.onFetchedLanguages(languages)
        XCTAssertTrue(view.updateCalled)
    }

}
