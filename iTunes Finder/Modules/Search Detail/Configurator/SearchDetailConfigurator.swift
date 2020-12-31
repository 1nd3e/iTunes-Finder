//
//  SearchDetailConfigurator.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

final class SearchDetailConfigurator {
    
    static func configure(with album: Album) -> UIViewController {
        let view = SearchDetailViewController()
        let router = SearchDetailRouter(view: view)
        let presenter = SearchDetailPresenter(view: view, router: router, album: album)
        view.presenter = presenter
        
        return view
    }
    
}
