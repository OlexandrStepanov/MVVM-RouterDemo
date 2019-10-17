//
//  RepoModel+Mock.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 17/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import Foundation
@testable import MVVM_RouterDemo

extension RepoModel {
    static var testRepo: RepoModel {
        return RepoModel(name: "Swift", description: "The Swift Programming Language", owner: RepoOwner(login: "apple"), url: URL(string: "https://github.com/apple/swift")!)
    }
}
