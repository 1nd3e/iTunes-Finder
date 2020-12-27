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

final class SearchPresenter: NSObject, SearchPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchViewProtocol?
    private let router: SearchRouterProtocol
    
    // MARK: - Initializers
    
    init(view: SearchViewProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - UICollectionView Data Source

extension SearchPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionView Delegate Flow Layout

extension SearchPresenter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 50, height: 50) }
        
        // Getting collection view's layout insets
        let sectionInsets = collectionViewLayout.sectionInset.left + collectionViewLayout.sectionInset.right
        let interitemSpacing = collectionViewLayout.minimumInteritemSpacing
        let insets = sectionInsets + interitemSpacing
        
        // Make calculations of cell size to fit 2 cells in a single row
        let viewWidth = collectionView.bounds.size.width
        let estimatedItemSize = (viewWidth - insets) / 2
        let size = CGSize(width: estimatedItemSize, height: estimatedItemSize)

        return size
    }
    
}
