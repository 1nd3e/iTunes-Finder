//
//  SearchDetailViewController.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

final class SearchDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: SearchDetailPresenterProtocol?
    
    // MARK: - Private Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.alpha = 0
        tableView.register(AlbumTableViewHeader.self, forHeaderFooterViewReuseIdentifier: AlbumTableViewHeader.identifier)
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
        
        return tableView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .large
        } else {
            activityIndicatorView.style = .gray
        }
        
        return activityIndicatorView
    }()
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVisualAppearance()
        configureViews()
        
        presenter?.fetchSongs()
    }
    
}

// MARK: - Visual Appearance

extension SearchDetailViewController {
    
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
        self.navigationItem.title = "Album Info"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
}

// MARK: - Layout

extension SearchDetailViewController {
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureActivityIndicatorView()
        configureTableView()
    }
    
    // Configures an activity indicator to display loading process.
    private func configureActivityIndicatorView() {
        self.view.addSubview(activityIndicatorView)
        
        // Setting up constraints
        activityIndicatorView.centerXToSuperview()
        activityIndicatorView.centerYToSuperview()
    }
    
    // Configures a table view to display search history.
    private func configureTableView() {
        self.view.addSubview(tableView)
        
        // Setting up constraints
        tableView.horizontalToSuperview()
        tableView.verticalToSuperview(usingSafeArea: true)
    }
    
}

// MARK: - SearchDetailPresenter Delegate

extension SearchDetailViewController: SearchDetailViewProtocol {
    
    // Reloads the table view with a new data.
    func shouldReloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            // Animating presentation of the table view
            UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut) {
                self?.tableView.alpha = 1
            } completion: { _ in
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
}
