//
//  RepoSearchRouter.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import UIKit

class RepoSearchRouter: MVVMRouter {
    
    enum RouteType {
        case repoDetails(RepoModel)
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        guard let baseViewController = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .repoDetails(let repo):
            let detailsRouter = RepoDetailsRouter()
            let presentationContext = RepoDetailsRouter.PresentationContext.view(repo)
            detailsRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
