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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.identifier)
        tableView.sectionHeaderHeight = 16
        tableView.sectionFooterHeight = 16
        
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
        
        return tableView
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
        configureTableView()
    }
    
    // Configures a table view to display search history.
    private func configureTableView() {
        self.view.addSubview(tableView)
        
        // Setting up constraints
        tableView.horizontalToSuperview()
        tableView.verticalToSuperview(usingSafeArea: true)
    }
    
}

// MARK: - SearchHistoryPresenter Delegate

extension SearchHistoryViewController: SearchHistoryViewProtocol {
    // Prepares the table view for changes in it's content.
    func tableView(shouldSetUpdates state: Bool) {
        switch state {
        case true:
            tableView.beginUpdates()
        case false:
            tableView.endUpdates()
        }
    }
    
    // Inserts rows in the table view.
    func tableView(shouldInsertRowsAt indexPath: [IndexPath]) {
        tableView.insertRows(at: indexPath, with: .automatic)
    }
    
    // Moves rows in the table view.
    func tableView(shouldMoveRowAt indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    // Reloads rows in the table view.
    func tableView(shouldReloadRowsAt indexPath: [IndexPath]) {
        tableView.reloadRows(at: indexPath, with: .automatic)
    }
    
    // Deletes rows in the table view.
    func tableView(shouldDeleteRowsAt indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .automatic)
    }
    
}
