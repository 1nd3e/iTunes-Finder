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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.delegate = presenter as? UICollectionViewDelegate
        
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var placeholderView: PlaceholderView = {
        let image = UIImage(named: "search-placeholder")
        let title = "Empty";  let subtitle = "Try searching for a some song."
        let placeholderView = PlaceholderView(image: image, title: title, subtitle: subtitle)
        
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
        configureCollectionView()
        configurePlaceholderView()
    }
    
    // Configures a search bar in the navigation bar.
    private func configureSearchBar() {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Setting up the search bar
        searchController.searchBar.placeholder = "Artists, songs, or albums"
        searchController.searchBar.tintColor = .systemPink
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // Configures a collection view.
    private func configureCollectionView() {
        self.view.addSubview(collectionView)
        
        // Setting up constraints
        collectionView.horizontalToSuperview(usingSafeArea: true)
        collectionView.verticalToSuperview(usingSafeArea: true)
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
