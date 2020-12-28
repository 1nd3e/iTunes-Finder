//
//  SearchPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

protocol SearchViewProtocol: class {
    func shouldPresentCollectionPlaceholder()
    func shouldReloadCollectionData()
    func shouldHideCollectionPlaceholder()
}

protocol SearchPresenterProtocol {
    init(view: SearchViewProtocol, router: SearchRouterProtocol)
}

final class SearchPresenter: NSObject, SearchPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchViewProtocol?
    private let router: SearchRouterProtocol
    
    private var searchInProgress = false
    private var searchData: [Album] = [] {
        didSet {
            self.view?.shouldReloadCollectionData()
        }
    }
    
    // MARK: - Initializers
    
    init(view: SearchViewProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - UICollectionView Data Source

extension SearchPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        
        // Configuring the cell with data from the model
        let model = searchData[indexPath.row]
        cell.configure(with: model)
        
        return cell
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

// MARK: - UISearchBar Delegate

extension SearchPresenter: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Hiding a placeholder view when search bar text did begin editing
        self.view?.shouldHideCollectionPlaceholder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Requests data using a search query
        if let searchText = searchBar.text {
            DataProvider.shared.get(albumsWithName: searchText) { albums in
                self.searchData = albums
            }
            
            searchInProgress = true
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Presents a placeholder view if there is no searching tasks
        if searchInProgress == false {
            self.view?.shouldPresentCollectionPlaceholder()
        }
    }
    
}
