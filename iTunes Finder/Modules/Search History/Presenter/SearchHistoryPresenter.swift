//
//  SearchHistoryPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit
import CoreData

protocol SearchHistoryViewProtocol: class {
    func tableView(shouldSetUpdates state: Bool)
    func tableView(shouldInsertRowsAt indexPath: [IndexPath])
    func tableView(shouldMoveRowAt indexPath: IndexPath, to newIndexPath: IndexPath)
    func tableView(shouldReloadRowsAt indexPath: [IndexPath])
    func tableView(shouldDeleteRowsAt indexPath: [IndexPath])
}

protocol SearchHistoryPresenterProtocol {
    init(view: SearchHistoryViewProtocol, router: SearchHistoryRouterProtocol)
}

final class SearchHistoryPresenter: NSObject, SearchHistoryPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchHistoryViewProtocol?
    private let router: SearchHistoryRouterProtocol
    
    private lazy var fetchedResultsController: NSFetchedResultsController<SearchItem> = {
        let context = CoreDataStack.shared.viewContext
        
        let fetchRequest: NSFetchRequest<SearchItem> = SearchItem.fetchRequest()
        fetchRequest.fetchBatchSize = 24
        
        let sortByCreatedDate = NSSortDescriptor(key: "createdDate", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedDate]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            print("Unable to fetch data: \(error.localizedDescription)")
        }
        
        return fetchedResultsController
    }()
    
    // MARK: - Initializers
    
    init(view: SearchHistoryViewProtocol, router: SearchHistoryRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - UITableView Data Source

extension SearchHistoryPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchItems = fetchedResultsController.fetchedObjects {
            return searchItems.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.identifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        
        let model = fetchedResultsController.object(at: indexPath)
        cell.configure(with: model)
        
        return cell
    }
    
}

// MARK: - UITableView Delegate

extension SearchHistoryPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - NSFetchedResultsController Delegate

extension SearchHistoryPresenter: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.tableView(shouldSetUpdates: true)
    }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                view?.tableView(shouldInsertRowsAt: [newIndexPath])
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                view?.tableView(shouldMoveRowAt: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                view?.tableView(shouldReloadRowsAt: [indexPath])
            }
        case .delete:
            if let indexPath = indexPath {
                view?.tableView(shouldDeleteRowsAt: [indexPath])
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.tableView(shouldSetUpdates: false)
    }
    
}
