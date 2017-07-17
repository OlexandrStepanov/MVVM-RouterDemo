//
//  RepoDetailsRouter.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import UIKit

class RepoDetailsRouter: MVVMRouter {
    
    enum PresentationContext {
        case view(RepoModel)
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        switch presentationContext {
        case .view(let repo):
            let viewController = StoryboardScene.Main.instantiateRepoDetailsViewController()
            
            let viewModel = RepoDetailsViewModel.init(with: self, repo: repo)
            viewController.viewModel = viewModel
            
            baseVC.navigationController?.pushViewController(viewController, animated: true)
            baseViewController = baseVC
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}

