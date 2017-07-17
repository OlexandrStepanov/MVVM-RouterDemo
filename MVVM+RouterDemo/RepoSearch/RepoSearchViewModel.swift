//
//  RepoSearchViewModel.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import RxSwift
import RxCocoa

struct RepoSearchListCellViewModel {
    let title: String
    let description: String
    
    init(with repo: RepoModel) {
        title = repo.name
        description = repo.description
    }
}

protocol RepoSearchViewModelProtocol: MVVMViewModel {
    var searchText: PublishSubject<String?> { get }
    var listItems: Variable<[RepoSearchListCellViewModel]> { get }
    var listIndexSelected: PublishSubject<Int> { get }
}

class RepoSearchViewModel: RepoSearchViewModelProtocol {
    
    let searchText = PublishSubject<String?>()
    let listItems = Variable<[RepoSearchListCellViewModel]>([])
    let listIndexSelected = PublishSubject<Int>()
    
    private var currentSearchResult = [RepoModel]()
    
    let router: MVVMRouter
    
    private let disposeBag = DisposeBag()
    private let githubService: GithubServiceProtocol
    
    init(with router: MVVMRouter, githubService: GithubServiceProtocol = GithubService()) {
        self.router = router
        self.githubService = githubService
        
        setupBundings()
    }
    
    func setupBundings() {
        
        //  Make delay of 0.5 second
        searchText.debounce(0.5, scheduler: MainScheduler.instance)
            
        //  Make request on github
        .flatMapLatest({ [weak self] query -> GithubServiceSearchResult in
            
            guard let `self` = self, let query = query, query.characters.count > 0 else {
                return GithubServiceSearchResult.just([])
            }
            
            return self.githubService.searchRepo(with: query)
        })
        .subscribe(onNext: { [weak self] repos in
            //  Store & convert response
            self?.currentSearchResult = repos
            self?.listItems.value = repos.map({ repo -> RepoSearchListCellViewModel in
                return RepoSearchListCellViewModel.init(with: repo)
            })
            
        }, onError: { [weak self] error in
            //  Just print an error and display empty result
            print("Got an error from Github: \(error)")
            self?.currentSearchResult = []
            self?.listItems.value = []
        })
        .addDisposableTo(disposeBag)
        
        
        listIndexSelected.subscribe(onNext: { [weak self] index in
            guard let `self` = self else {
                return
            }
            
            guard index < self.currentSearchResult.count else {
                print("Index is not reachable: \(index); \(self.currentSearchResult)")
                return
            }
            
            let repo = self.currentSearchResult[index]
            self.router.enqueueRoute(with: RepoSearchRouter.RouteType.repoDetails(repo))
        }).addDisposableTo(disposeBag)
    }
}
