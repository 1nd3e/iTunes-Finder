//
//  SearchHistoryPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchHistoryViewProtocol: class {}

protocol SearchHistoryPresenterProtocol {
    init(view: SearchHistoryViewProtocol, router: SearchHistoryRouterProtocol)
}

final class SearchHistoryPresenter: SearchHistoryPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchHistoryViewProtocol?
    private let router: SearchHistoryRouterProtocol
    
    // MARK: - Initializers
    
    init(view: SearchHistoryViewProtocol, router: SearchHistoryRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
