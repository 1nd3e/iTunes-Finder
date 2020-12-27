//
//  CoreDataStack.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 28.12.2020.
//

import CoreData

final class CoreDataStack {
    
    // MARK: - Types
    
    typealias ContextBlock = (NSManagedObjectContext) -> Void
    
    // MARK: - Public Properties
    
    static let shared = CoreDataStack()
    
    // MARK: - Private Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unable to load Persistent Stores: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    private(set) lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    // MARK: - Methods
    
    // Performs data saving in the background context.
    func save(_ block: @escaping ContextBlock) {
        let context = backgroundContext
        
        context.perform {
            block(context)
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    print("Unable to save context: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
