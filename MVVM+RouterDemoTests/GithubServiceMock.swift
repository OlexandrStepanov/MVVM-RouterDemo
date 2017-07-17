//
//  GithubServiceMock.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 17/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import Foundation
@testable import MVVM_RouterDemo

class GithubServiceMock: GithubServiceProtocol {
    
    //  Simply returns the result from one RepoModel.testRepo for any query 
    func searchRepo(with query: String) -> GithubServiceSearchResult {
        return GithubServiceSearchResult.just([RepoModel.testRepo])
    }
}
