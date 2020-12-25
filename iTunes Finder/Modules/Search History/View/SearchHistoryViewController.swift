//
//  SearchHistoryViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SearchHistoryPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - SearchHistoryPresenter Delegate

extension SearchHistoryViewController: SearchHistoryViewProtocol {}
