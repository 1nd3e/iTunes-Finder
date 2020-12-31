//
//  SearchResultsConfigurator.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

final class SearchResultsConfigurator {
    
    static func configure() -> UIViewController {
        let view = SearchResultsViewController()
        let router = SearchResultsRouter(view: view)
        let presenter = SearchResultsPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
    static func configure(with query: String) -> UIViewController {
        let view = SearchResultsViewController()
        let router = SearchResultsRouter(view: view)
        let presenter = SearchResultsPresenter(view: view, router: router, query: query)
        view.presenter = presenter
        view.navigationItem.title = query
        
        return view
    }
    
}
