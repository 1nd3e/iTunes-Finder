//
//  SearchConfigurator.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

final class SearchConfigurator {
    
    static func configure() -> UIViewController {
        let view = SearchViewController()
        let navigationController = UINavigationController(rootViewController: view)
        let router = SearchRouter(view: view)
        let presenter = SearchPresenter(view: view, router: router)
        view.presenter = presenter
        
        return navigationController
    }
    
}
