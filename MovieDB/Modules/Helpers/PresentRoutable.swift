//
//  Presentable.swift
//  KTK
//
//  Created by Dmitriy Safarov on 22/02/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import LightRoute

// Access to functions of NavigationController in the router 

protocol PresentRoutable: Routable {
    
}

extension PresentRoutable {
    
    func push<T>(storyboard: UIStoryboard,
                 moduleInput type: T.Type,
                 animation: Bool = true) throws -> TransitionNode<T> {
        return try show(storyboard: storyboard, moduleInput: type, navigationStyle: .push)
    }
    
    func pop<T>(storyboard: UIStoryboard,
                moduleInput type: T.Type,
                animation: Bool = true) throws -> TransitionNode<T> {
        return try show(storyboard: storyboard, moduleInput: type, navigationStyle: .pop)
    }
    
    func present<T>(storyboard: UIStoryboard,
                    moduleInput type: T.Type,
                    animation: Bool = true) throws -> TransitionNode<T> {
        return try show(storyboard: storyboard, moduleInput: type, navigationStyle: .present)
    }
    
    private func show<T>(storyboard: UIStoryboard,
                         moduleInput type: T.Type,
                         navigationStyle: TransitionStyle.NavigationStyle,
                         animation: Bool = true) throws -> TransitionNode<T> {
        do {
            return try transitionHandler
            .forStoryboard(factory: storyboard.factory,
                           to: type)
            .transition(animate: true)
            .to(preferred: TransitionStyle.navigation(style: navigationStyle))
        } catch {
            print("LightRoute: \(error.localizedDescription)")
            throw error
        }
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        transitionHandler.navigationController?.present(viewController, animated: animated, completion: nil)
    }
    
    func popViewController() {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        transitionHandler.navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        transitionHandler.navigationController?.popToRootViewController(animated: true)
    }
    
    func popToViewController(_ anyClass: AnyClass) {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        for viewController in transitionHandler.navigationController?.viewControllers ?? [] {
            if viewController.isKind(of: anyClass) {
                transitionHandler.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    func show(_ viewController: UIViewController) {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        transitionHandler.show(viewController, sender: nil)
    }
    
}
