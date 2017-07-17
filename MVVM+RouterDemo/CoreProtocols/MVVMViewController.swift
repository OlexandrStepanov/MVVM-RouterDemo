//
//  MVVMViewControllerProtocol.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

protocol MVVMViewController: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}
