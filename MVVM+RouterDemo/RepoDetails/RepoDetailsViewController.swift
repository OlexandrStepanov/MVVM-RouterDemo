//
//  RepoDetailsViewController.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoDetailsViewController: UIViewController, MVVMViewController {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var urlButton: UIButton!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var viewModel: RepoDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        //  Setup bindings
        viewModel.title.asObservable().bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.author.asObservable().bind(to: authorLabel.rx.text).disposed(by: disposeBag)
        viewModel.description.asObservable().bind(to: descriptionTextView.rx.text).disposed(by: disposeBag)
        viewModel.url.asObservable().bind(to: urlButton.rx.title(for: .normal)).disposed(by: disposeBag)
    }

}
