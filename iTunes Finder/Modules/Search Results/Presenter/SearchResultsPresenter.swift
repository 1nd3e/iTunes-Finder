//
//  SearchResultsPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

protocol SearchResultsViewProtocol: class {
    func shouldReloadData()
    func shouldPresent(album: Album)
}

protocol SearchResultsPresenterProtocol {
    init(view: SearchResultsViewProtocol, router: SearchResultsRouterProtocol)
}

final class SearchResultsPresenter: NSObject, SearchResultsPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchResultsViewProtocol?
    private let router: SearchResultsRouterProtocol
    
    private let throttler = Throttler(delay: 0.5)
    private var albums: [Album] = [] {
        didSet {
            view?.shouldReloadData()
        }
    }
    
    // MARK: - Initializers
    
    init(view: SearchResultsViewProtocol, router: SearchResultsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    convenience init(view: SearchResultsViewProtocol, router: SearchResultsRouterProtocol, query: String) {
        self.init(view: view, router: router)
        search(text: query)
    }
    
    // MARK: - Methods
    
    // Send a delayed search query and display the new data in the collection.
    func search(text query: String) {
        throttler.throttle { [weak self] in
            Database.shared.save(query: query)
            DataProvider.shared.get(albumsWithName: query) { result in
                switch result {
                case .success(let albums):
                    // Setting albums sorted by release date
                    self?.albums = albums.sorted { (a, b) -> Bool in
                        return a.releaseDate > b.releaseDate
                    }
                case .failure(let error):
                    // Presenting an error message if something went wrong
                    DispatchQueue.main.async {
                        self?.router.presentAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
}

// MARK: - UICollectionView Data Source

extension SearchResultsPresenter: UICollectionViewDataSource {
    
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

extension SearchResultsPresenter: UICollectionViewDelegateFlowLayout {
    
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
        view?.shouldPresent(album: album)
    }
    
}

// MARK: - UISearchResultsUpdating

extension SearchResultsPresenter: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.isNotEmpty else { return }
        search(text: query)
    }
    
}
