//
//  RepoModel.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import Unbox


struct RepoModel {
    let name: String
    let description: String
    let owner: String
    let url: URL
}

extension RepoModel: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.description = try unboxer.unbox(key: "description")
        self.owner = try unboxer.unbox(keyPath: "owner.login")
        self.url = try unboxer.unbox(key: "html_url")
    }
}
