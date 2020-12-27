//
//  SearchHistoryViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: SearchHistoryPresenterProtocol?
    
    // MARK: - Private Properties
    
    private lazy var placeholderView: PlaceholderView = {
        let image = UIImage(named: "search-history-placeholder")
        let title = "No search history";  let subtitle = "Why don't you try searching for something? Lady Gaga, for example."
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

extension SearchHistoryViewController {
    
    // Groups all methods that are configuring the view’s visual appearance.
    private func configureVisualAppearance() {
        configureColors()
        configureNavigationTitle()
    }
    
    // Configures colors.
    private func configureColors() {
        // Setting up .systemBackground for the view's backgroundColor
        // to support dark theme in iOS 13 or newer.
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
        
        self.navigationItem.title = "History"
    }
    
}

// MARK: - Layout

extension SearchHistoryViewController {
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configurePlaceholderView()
    }
    
    // Configures a placeholder view.
    private func configurePlaceholderView() {
        self.view.addSubview(placeholderView)
        
        // Setting up constraints
        placeholderView.horizontalToSuperview()
        placeholderView.verticalToSuperview()
    }
    
}

// MARK: - SearchHistoryPresenter Delegate

extension SearchHistoryViewController: SearchHistoryViewProtocol {}
