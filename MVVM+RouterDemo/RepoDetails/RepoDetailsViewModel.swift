//
//  RepoDetailsViewModel.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import RxSwift
import RxRelay


protocol RepoDetailsViewModelProtocol: MVVMViewModel {
    var title: BehaviorRelay<String> { get }
    var author: BehaviorRelay<String> { get }
    var url: BehaviorRelay<String> { get }
    var description: BehaviorRelay<String> { get }
}

class RepoDetailsViewModel: RepoDetailsViewModelProtocol {
    
    let title: BehaviorRelay<String>
    let author: BehaviorRelay<String>
    let url: BehaviorRelay<String>
    let description: BehaviorRelay<String>
    
    let router: MVVMRouter
    
    init(with router: MVVMRouter, repo: RepoModel) {
        self.router = router
        
        title = BehaviorRelay<String>(value: repo.name)
        author = BehaviorRelay<String>(value: repo.owner)
        url = BehaviorRelay<String>(value: repo.url.absoluteString)
        description = BehaviorRelay<String>(value: repo.description)
    }
}

