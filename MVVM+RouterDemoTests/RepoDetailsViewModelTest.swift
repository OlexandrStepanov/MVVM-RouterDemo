//
//  RepoDetailsViewModelTest.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 15/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import XCTest
import UIKit
import RxSwift
@testable import MVVM_RouterDemo

class RepoDetailsRouterMock: MVVMRouter {
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}

class RepoDetailsViewModelTest: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testInitialization() {
        let repoModel = RepoModel.testRepo
        let routerMock = RepoDetailsRouterMock()
        let viewModel = RepoDetailsViewModel.init(with: routerMock, repo: repoModel)
        
        XCTAssertEqual(viewModel.title.value, repoModel.name)
        XCTAssertEqual(viewModel.description.value, repoModel.description)
        XCTAssertEqual(viewModel.author.value, repoModel.owner.login)
        XCTAssertEqual(viewModel.url.value, repoModel.url.absoluteString)
    }
    
}
