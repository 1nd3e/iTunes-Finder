//
//  SearchRouter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchRouterProtocol {
    init(view: UIViewController)
    func moveToSearchDetail(with album: Album)
}

final class SearchRouter: SearchRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    
    // Moves view to a SearchDetail module.
    func moveToSearchDetail(with album: Album) {
        guard let view = view, let navigationController = view.navigationController else { return }
        let viewController = SearchDetailConfigurator.shared.configure(with: album)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
