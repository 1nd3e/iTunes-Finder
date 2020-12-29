//
//  SearchItem+Init.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import CoreData

extension SearchItem {
    
    // Initializes the model by taking all required properties during initialization.
    convenience init(query: String, createdDate: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.query = query
        self.createdDate = createdDate
    }
    
}
