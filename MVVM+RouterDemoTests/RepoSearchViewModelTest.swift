//
//  RepoSearchViewModelTest.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 15/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import XCTest
@testable import MVVM_RouterDemo

class RepoSearchRouterMock: MVVMRouter {
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    //  MARK: -
    
    var routeHistory: [RepoSearchRouter.RouteType] = []
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let routeType = context as? RepoSearchRouter.RouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        routeHistory.append(routeType)
    }

}

class RepoSearchViewModelTest: XCTestCase {
    
    var viewModel: RepoSearchViewModel!
    var router: RepoSearchRouterMock!
    
    override func setUp() {
        super.setUp()
        
        router = RepoSearchRouterMock()
        viewModel = RepoSearchViewModel(with: router, githubService: GithubServiceMock())
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testSearch() {
        viewModel.searchText.onNext("test")
        
        //  Wait for search test debounce
        let expectation = self.expectation(description: "searchDebounce")
        let _ = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.listItems.value.count, 1)
        
        if viewModel.listItems.value.count == 1 {
            XCTAssertEqual(viewModel.listItems.value[0].title, RepoModel.testRepo.name)
            XCTAssertEqual(viewModel.listItems.value[0].description, RepoModel.testRepo.description)
        }
    }
    
    func testListItemSelected() {
        viewModel.searchText.onNext("test")
        
        //  Wait for dearch test debounce
        let expectation = self.expectation(description: "searchDebounce")
        let _ = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        viewModel.listIndexSelected.onNext(0)
        
        XCTAssertEqual(router.routeHistory.count, 1)
        
        if router.routeHistory.count == 1 {
            XCTAssertEqual(router.routeHistory[0].description, "repoDetails")
        }
    }
    
}

extension RepoSearchRouter.RouteType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .repoDetails:
            return "repoDetails"
        }
    }
}
