//
//  SearchDetailRouter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

protocol SearchDetailRouterProtocol {
    init(view: UIViewController)
}

final class SearchDetailRouter: SearchDetailRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
