//
//  Database.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 28.12.2020.
//

import Foundation

final class Database {
    
    // MARK: - Properties
    
    static let shared = Database()
    
    // MARK: - Methods
    
    // Saves a search query to Core Data.
    func save(query: String) {
        CoreDataStack.shared.save { context in
            let createdDate = Date()
            _ = SearchItem(query: query, createdDate: createdDate, context: context)
        }
    }
    
}
