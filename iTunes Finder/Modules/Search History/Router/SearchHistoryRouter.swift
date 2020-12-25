//
//  SearchHistoryRouter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchHistoryRouterProtocol {
    init(view: UIViewController)
}

final class SearchHistoryRouter: SearchHistoryRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
