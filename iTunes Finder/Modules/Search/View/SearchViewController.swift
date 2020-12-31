//
//  SearchViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit
import TinyConstraints

final class SearchViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: SearchPresenterProtocol?
    
    // MARK: - Private Properties
    
    private lazy var placeholderView: PlaceholderView = {
        let image = UIImage(named: "search-placeholder")
        let title = "What're you looking for?";  let subtitle = "Search by iTunes Database"
        let placeholderView = PlaceholderView(image: image, title: title, subtitle: subtitle)
        
        if #available(iOS 13.0, *) {
            placeholderView.backgroundColor = .systemBackground
        } else {
            placeholderView.backgroundColor = .white
        }
        
        return placeholderView
    }()
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVisualAppearance()
        configureViews()
    }
    
}

// MARK: - Visual Appearance

extension SearchViewController {
    
    // Groups all methods that are configuring the view’s visual appearance.
    private func configureVisualAppearance() {
        configureColors()
        configureNavigationTitle()
    }
    
    // Configures colors.
    private func configureColors() {
        // Setting up .systemBackground for the view's backgroundColor
        // to support dark theme in iOS 13 or newer
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        
        self.view.tintColor = .systemPink
    }
    
    // Configures a title in the navigation bar.
    private func configureNavigationTitle() {
        // Asking the navigation bar to display a title using a larger font if it possible
        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        self.navigationItem.title = "Search"
    }
    
}

// MARK: - Layout

extension SearchViewController {
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureSearchBar()
        configurePlaceholderView()
    }
    
    // Configures a search bar in the navigation bar.
    private func configureSearchBar() {
        // Setting up the search controller with the search results controller
        guard let searchResultsController = SearchResultsConfigurator.configure() as? SearchResultsViewController else { return }
        searchResultsController.delegate  = self
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController.presenter as? UISearchResultsUpdating
        
        // Setting up the search bar
        searchController.searchBar.autocapitalizationType = .words
        searchController.searchBar.placeholder = "Artists, songs, or albums"
        searchController.searchBar.tintColor = .systemPink
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // Configures a placeholder view.
    private func configurePlaceholderView() {
        self.view.addSubview(placeholderView)
        
        // Setting up constraints
        placeholderView.horizontalToSuperview()
        placeholderView.verticalToSuperview()
    }
    
}

// MARK: - SearchPresenter Delegate

extension SearchViewController: SearchViewProtocol {}

// MARK: - SearchResultsViewController Delegate

extension SearchViewController: SearchResultsViewControllerDelegate {
    
    // Asks the presenter move to the SearchDetail module.
    func searchResults(didSelect album: Album) {
        presenter?.moveToSearchDetail(with: album)
    }
    
}
