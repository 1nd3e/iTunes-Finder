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
    func moveToSearchDetail(with album: Album)
}

final class SearchPresenter: NSObject, SearchPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchViewProtocol?
    private let router: SearchRouterProtocol
    
    // MARK: - Initializers
    
    init(view: SearchViewProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
    
    // Moves to the SearchDetail module.
    func moveToSearchDetail(with album: Album) {
        router.moveToSearchDetail(with: album)
    }
    
}
