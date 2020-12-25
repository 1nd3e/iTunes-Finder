//
//  SearchPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchViewProtocol: class {}

protocol SearchPresenterProtocol {
    init(view: SearchViewProtocol, router: SearchRouterProtocol)
}

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchViewProtocol?
    private let router: SearchRouterProtocol
    
    // MARK: - Initializers
    
    init(view: SearchViewProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
