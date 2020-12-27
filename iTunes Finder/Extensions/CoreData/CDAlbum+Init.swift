//
//  CDAlbum+Init.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 28.12.2020.
//

import CoreData

extension CDAlbum {
    
    // Initializes a model by taking a data from an Album model.
    convenience init(model: Album, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = model.id
        self.artworkUrl = model.artworkUrl
    }
    
}
