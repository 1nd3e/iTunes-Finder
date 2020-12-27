//
//  Database.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 28.12.2020.
//

import Foundation

class Database {
    
    // MARK: - Properties
    
    static let shared = Database()
    
    // MARK: - Methods
    
    // Saves an array with albums to Core Data.
    func save(data albums: [Album]) {
        albums.forEach { model in
            CoreDataStack.shared.save { context in
                _ = CDAlbum(model: model, context: context)
            }
        }
    }
    
}
