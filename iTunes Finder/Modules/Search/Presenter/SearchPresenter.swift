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
    
    private var albums: [Album] = [] {
        // Hiding a placeholder content if we have anything to present in the collection.
        // Otherwise, we should to display a placeholder.
        willSet {
            if newValue.count > 0 {
                view?.shouldHideCollectionPlaceholder()
            } else {
                view?.shouldPresentCollectionPlaceholder()
            }
        }
        
        // Reloading data in the collection view.
        didSet {
            view?.shouldReloadCollectionData()
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
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        
        // Configuring the cell with data from the model
        let album = albums[indexPath.row]
        cell.configure(with: album)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Presents a SearchDetail module with the selected album
        let album = albums[indexPath.row]
        router.moveToSearchDetail(with: album)
    }
    
}

// MARK: - UISearchBar Delegate

extension SearchPresenter: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Requests data for the presentation
            DataProvider.shared.get(albumsWithName: searchText) { [weak self] albums in
                self?.albums = albums
            }
            // Saves a search query
            Database.shared.save(query: searchText)
        }
    }
    
}
