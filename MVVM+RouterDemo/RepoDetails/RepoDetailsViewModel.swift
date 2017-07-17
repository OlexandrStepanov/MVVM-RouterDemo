//
//  RepoDetailsViewModel.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import RxSwift


protocol RepoDetailsViewModelProtocol: MVVMViewModel {
    var title: Variable<String> { get }
    var author: Variable<String> { get }
    var url: Variable<String> { get }
    var description: Variable<String> { get }
}

class RepoDetailsViewModel: RepoDetailsViewModelProtocol {
    
    let title: Variable<String>
    let author: Variable<String>
    let url: Variable<String>
    let description: Variable<String>
    
    let router: MVVMRouter
    
    init(with router: MVVMRouter, repo: RepoModel) {
        self.router = router
        
        title = Variable<String>(repo.name)
        author = Variable<String>(repo.owner)
        url = Variable<String>(repo.url.absoluteString)
        description = Variable<String>(repo.description)
    }
}

