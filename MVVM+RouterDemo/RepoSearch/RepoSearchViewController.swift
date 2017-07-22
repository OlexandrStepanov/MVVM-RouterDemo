//
//  RepoSearchViewController.swift
//  MVVM+RouterDemo
//
//  Created by Oleksandr Stepanov on 11/07/2017.
//  Copyright © 2017 OleksandrStepanov. All rights reserved.
//

import RxSwift
import RxCocoa

class RepoSearchViewController: UIViewController, MVVMViewController {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var searchTextfield: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var resultlLabel: UILabel!
    @IBOutlet private weak var loadingWheel: UIActivityIndicatorView!
    
    var viewModel: RepoSearchViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        //  Setup bindings
        
        searchTextfield.rx.text.bind(to: viewModel.searchText).addDisposableTo(disposeBag)
        viewModel.showLoadingWheel.asObservable().bind(to: loadingWheel.rx.isAnimating).addDisposableTo(disposeBag)
        
        viewModel.listItems.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell: UITableViewCell
            let reuseId = "RepoCell"
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: reuseId) {
                cell = reusedCell
            }
            else {
                cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: reuseId)
            }
            
            cell.textLabel?.text = element.title
            cell.detailTextLabel?.text = element.description
            
            return cell
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            
            self?.viewModel.listIndexSelected.onNext(indexPath.row)
            
        }).addDisposableTo(disposeBag)
        
        viewModel.listItems.asObservable().subscribe(onNext: { [weak self] list in
            guard let `self` = self else {
                return
            }
            
            if list.count > 0 {
                self.resultlLabel.text = "Repositories found: \(list.count)"
            }
            else {
                self.resultlLabel.text = "No result"
            }
        }).addDisposableTo(disposeBag)
    }

}
