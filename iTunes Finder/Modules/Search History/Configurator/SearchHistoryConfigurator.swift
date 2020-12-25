//
//  SearchHistoryConfigurator.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

final class SearchHistoryConfigurator {
    
    // MARK: - Types
    
    static let shared = SearchHistoryConfigurator()
    
    // MARK: - Methods
    
    func configure() -> UIViewController {
        let view = SearchHistoryViewController()
        let navigationController = UINavigationController(rootViewController: view)
        let router = SearchHistoryRouter(view: view)
        let presenter = SearchHistoryPresenter(view: view, router: router)
        view.presenter = presenter
        
        return navigationController
    }
    
}
