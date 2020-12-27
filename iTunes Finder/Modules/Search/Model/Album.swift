//
//  Album.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import Foundation

struct Album {
    
    let id: String
    let artworkUrl: String
    
    init?(data: Dictionary<String, Any>) {
        guard
            let id = data["collectionId"] as? Int,
            let artworkUrl = data["artworkUrl100"] as? String
        else {
            return nil
        }
        
        self.id = String(id)
        self.artworkUrl = artworkUrl
    }
    
}
