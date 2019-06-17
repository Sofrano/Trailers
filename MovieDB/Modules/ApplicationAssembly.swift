//
//  ApplicationAssembly.swift
//  KTK
//
//  Created by Dmitriy Safarov on 04/01/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

final class ApplicationAssembly {
    
    static var assemblies: [Assembly] = [
        GenresPagerAssemblyContainer(),
        GenreListAssemblyContainer(),
        MovieWallAssemblyContainer(),
        LanguageAssemblyContainer(),
        EntryPointAssemblyContainer(),
        VideoListAssemblyContainer(),
        ImageListAssemblyContainer(),
        CastingListAssemblyContainer(),
        YTAssemblyContainer(),
        TextListAssemblyContainer()
    ]
    
}

extension SwinjectStoryboard {
    
    private static func setupContainer(with additionalAssemblies: [Assembly]) {
        var assemblies: [Assembly] = ApplicationAssembly.assemblies
        assemblies.append(contentsOf: additionalAssemblies)
        if let container = Assembler(assemblies).resolver as? Container {
            SwinjectStoryboard.defaultContainer = container
        }
    }
    
    @objc public class func setup() {
        // workaround to fix the issue https://github.com/Swinject/Swinject/issues/218
        Container.loggingFunction = nil
        setupContainer(with: [])
    }
}
