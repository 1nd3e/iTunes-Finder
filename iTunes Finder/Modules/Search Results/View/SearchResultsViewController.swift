//
//  SearchResultsViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

protocol SearchResultsViewControllerDelegate: class {
    func searchResults(didSelect album: Album)
}

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: SearchResultsPresenterProtocol?
    weak var delegate: SearchResultsViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.delegate = presenter as? UICollectionViewDelegate
        
        return collectionView
    }()
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVisualAppearance()
        configureViews()
    }
    
}

// MARK: - Visual Appearance

extension SearchResultsViewController {
    
    // Groups all methods that are configuring the view’s visual appearance.
    private func configureVisualAppearance() {
        configureColors()
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
    
}

// MARK: - Layout

extension SearchResultsViewController {
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureCollectionView()
    }
    
    // Configures a collection view.
    private func configureCollectionView() {
        self.view.addSubview(collectionView)
        
        // Setting up constraints
        collectionView.horizontalToSuperview(usingSafeArea: true)
        collectionView.verticalToSuperview(usingSafeArea: true)
    }
    
}

// MARK: - SearchResultsPresenter Delegate

extension SearchResultsViewController: SearchResultsViewProtocol {
    
    // Reloads data in the collection view.
    func shouldReloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // Tells the delegate that user did select an item in the search results.
    func shouldPresent(album: Album) {
        delegate?.searchResults(didSelect: album)
    }
    
}
