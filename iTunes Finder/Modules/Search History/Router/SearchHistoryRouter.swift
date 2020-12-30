//
//  SearchHistoryRouter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchHistoryRouterProtocol {
    init(view: UIViewController)
    
    func moveToSearchResults(with query: String)
    func moveToSearchDetail(with album: Album)
}

final class SearchHistoryRouter: SearchHistoryRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    
    // Moves view to a SearchResults module.
    func moveToSearchResults(with query: String) {
        guard
            let view = view as? SearchHistoryViewController,
            let navigationController = view.navigationController,
            let viewController = SearchResultsConfigurator.shared.configure(with: query) as? SearchResultsViewController
        else {
            return
        }
        
        viewController.delegate = view
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // Moves view to a SearchDetail module.
    func moveToSearchDetail(with album: Album) {
        guard let view = view, let navigationController = view.navigationController else { return }
        let viewController = SearchDetailConfigurator.shared.configure(with: album)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
