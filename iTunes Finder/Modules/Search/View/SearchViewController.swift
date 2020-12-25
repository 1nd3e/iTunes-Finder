//
//  SearchViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SearchPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - SearchPresenter Delegate

extension SearchViewController: SearchViewProtocol {}
