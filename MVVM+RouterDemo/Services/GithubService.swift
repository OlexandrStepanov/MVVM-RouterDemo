//
//  GithubService.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

typealias GithubServiceSearchResult = Observable<[RepoModel]>

protocol GithubServiceProtocol {
    func searchRepo(with query: String) -> GithubServiceSearchResult
}


class GithubService: GithubServiceProtocol {
    
    enum ErrorType: Error {
        case invalidResponseFormat(Error)
    }
    
    
    func searchRepo(with query: String) -> GithubServiceSearchResult {
        let url = "https://api.github.com/search/repositories"
        let params = ["q": query]
        
        return GithubServiceSearchResult.create { (observer) -> Disposable in
            let requestReference = Alamofire.request(url, method: .get, parameters: params).responseJSON(completionHandler: { response in
                    if let data = response.data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let searchResult = try jsonDecoder.decode(RepoSearchResult.self, from: data)
                            observer.onNext(searchResult.repos)
                            observer.onCompleted()
                        } catch {
                            observer.onError(ErrorType.invalidResponseFormat(error))
                        }
                        
                    }else if let error = response.result.error {
                        observer.onError(error)
                    }
                })
            
            return Disposables.create(with: {
                requestReference.cancel()
            })
        }
    }
    
}
