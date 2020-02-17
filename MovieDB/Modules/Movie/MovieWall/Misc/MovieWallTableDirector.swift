//
//  MovieWallTableDirector.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import TableKit

protocol MovieWallTableDirector {
    
    func update(with viewModel: MovieWallViewModel)
    
}

class MovieWallDefaultTableDirector: MovieWallTableDirector {
    
    private var viewModel: MovieWallViewModel!
    private var tableKit: TableDirector!
    
    // Used when drawing the table as header and footer views
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    init(tableView: UITableView) {
        tableKit = TableDirector(tableView: tableView)
    }
    
    public func update(with viewModel: MovieWallViewModel) {
        self.viewModel = viewModel
        configureTableView()
    }
    
}

extension MovieWallDefaultTableDirector {
    
    private func configureTableView() {
        tableKit.clear()
        let headerSliderSection = createHeaderSliderSection(model: viewModel.headerSliderViewModel)
        addMediaTitle(to: headerSliderSection)
        if let productionViewModel = viewModel.productionStatusViewModel {
            addProductionStatus(to: headerSliderSection, with: productionViewModel)
        }
        addShortOverview(to: headerSliderSection, with: viewModel.mediaOverviewViewModel)
        tableKit.append(section: headerSliderSection)
        tableKit.append(section: createImageSection(model: viewModel.imagesViewModel))
        tableKit.append(section: createCastSection(model: viewModel.castViewModel))
        tableKit.append(section: createVideoSection(model: viewModel.videosViewModel))
        tableKit.reload()
    }
    
    private func createImageSection(model: SectionImageCollectionViewModel) -> TableSection {
        let configuration = HorizontalCollectionConfiguration()
        configuration.itemSize = CGSize(width: 200, height: 120)
        model.configuration = configuration
        //model.configuration = configuration
        
        let imagesRow = TableRow<HorizontalCollectionTableViewCell>(item: model)
        let section = createDefaultSection()
        section.append(row: imagesRow)
        
        return section
    }
    
    private func createVideoSection(model: SectionImageCollectionViewModel) -> TableSection {
        let configuration = HorizontalCollectionConfiguration()
        configuration.itemSize = CGSize(width: 200, height: 120)
        configuration.registerCell = (class: VideoCollectionViewCell.self, identifier: "video")
        model.configuration = configuration
        
        let row = TableRow<HorizontalCollectionTableViewCell>(item: model)
        let section = createDefaultSection()
        section.append(row: row)
        
        return section
    }
    
    private func createCastSection(model: CastCollectionViewModel) -> TableSection {
        let configuration = HorizontalCollectionConfiguration()
        configuration.registerCell = (class: CastCollectionViewCell.self, identifier: "cast")
        configuration.configureCollectionCell = { (collectionCell, index) in
            guard let castCell = collectionCell as? CastCollectionViewCell else { return }
            castCell.configure(model.casts[index])
        }
        model.configuration = configuration
        
        let row = TableRow<HorizontalCollectionTableViewCell>(item: model)
        let section = createDefaultSection()
        section.append(row: row)
        
        return section
    }
    
    private func addMediaTitle(to section: TableSection) {
        //Add short header row
        let mediaTitleViewModel = viewModel.mediaTitleViewModel
        let configuration = ViewModelConfiguration()
        configuration.onConfigureView = { view in
            view.layer.zPosition = 999
        }
        mediaTitleViewModel.configuration = configuration
        
        let row = TableRow<MediaTitleTableViewCell>(item: viewModel.mediaTitleViewModel)
        section.append(row: row)
        
        /*
         //Add overview with poster row
         let imageOverviewRow = TableRow<ImageOverviewTableViewCell>(item: movieDetails)
         .on(.click) { _ in
         self.output?.selectOverview(movieDetails.overview ?? "")
         }
         section.append(row: imageOverviewRow)*/
    }
    
    private func addProductionStatus(to section: TableSection,
                             with model: ProductionCellViewModel) {
        let productionRow = TableRow<ProductionStatusTableViewCell>(item: model)
        section.append(row: productionRow)
    }
    
    private func addShortOverview(to section: TableSection,
                          with model: MediaOverviewViewModel) {
        let imageOverviewRow = TableRow<MediaOverviewTableViewCell>(item: model)
            .on(.click) { _ in
                model.invoke(action: .openDetails)
        }
        section.append(row: imageOverviewRow)
    }
    
    private func createDefaultSection() -> TableSection {
        let sectionHeaderHeight: CGFloat = 10
        let sectionFooterHeight: CGFloat = 0.1
        
        let section = TableSection(headerView: transparentView,
                                   footerView: transparentView)
        section.headerHeight = sectionHeaderHeight
        section.footerHeight = sectionFooterHeight
        
        return section
    }
    
    private func createHeaderSliderSection(model: ImageCollectionViewModel) -> TableSection {
        let section = createDefaultSection()
        section.headerHeight = 0.1
        
        let configuration = PagerCellConfiguration(width: tableKit.tableView?.frame.width ?? 0)
        configuration.transform = CGAffineTransform(scaleX: 1, y: 1)
        configuration.transformerType = .crossFading
        configuration.height = configuration.width * 0.56
        configuration.slidingInterval = 15.0
        configuration.onConfigureView = { view in
            // Configure gradient
            let  bottomGradient = CAGradientLayer()
            bottomGradient.colors = [UIColor.clear.cgColor,
                                     UIColor.appColor.behance.cgColor]
            bottomGradient.locations = [0.0 , 1.0]
            let cellHeight = configuration.width * 0.56
            let yPosition = cellHeight - cellHeight / 6
            bottomGradient.frame = CGRect(x: 0.0,
                                          y: yPosition,
                                          width: configuration.width,
                                          height: cellHeight / 6)
            view.layer.addSublayer(bottomGradient)
        }
        model.configuration = configuration
        
        let posterRow = TableRow<PagerTableViewCell>(item: model)
        section.append(row: posterRow)
        
        return section
    }
    
    
}
