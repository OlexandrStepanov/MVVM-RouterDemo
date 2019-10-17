//
//  RepoModel.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import Foundation

struct RepoSearchResult: Codable {
    let repos: [RepoModel]
    
    enum CodingKeys: String, CodingKey {
        case repos = "items"
    }
}

struct RepoModel: Codable {
    let name: String
    let description: String?
    let owner: RepoOwner
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case owner
        case url = "html_url"
    }
}

struct RepoOwner: Codable {
    let login: String
}
