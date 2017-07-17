//
//  UICoordinator.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 14/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import UIKit

class UICoordinator {
    
    func presentInitialScreen(on window: UIWindow) {
        let router = RepoSearchRouter()
        let navigationVC = StoryboardScene.Main.instantiateNavigationController()
        let viewModel = RepoSearchViewModel.init(with: router)
        
        guard let viewController = navigationVC.topViewController as? RepoSearchViewController else {
            assertionFailure("Main storyboard configured not properly")
            return
        }
        
        viewController.viewModel = viewModel
        router.baseViewController = viewController
        
        window.rootViewController = navigationVC
    }
    
}
