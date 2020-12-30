//
//  Album.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import Foundation

struct Album: ParsableModel {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    let artistName: String
    let price: String
    let currency: String
    let artworkUrl: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let id = data["collectionId"] as? Int,
            let name = data["collectionName"] as? String,
            let artistName = data["artistName"] as? String,
            let price = data["collectionPrice"] as? Double,
            let currency = data["currency"] as? String,
            let artworkUrl = data["artworkUrl100"] as? String
        else {
            return nil
        }
        
        self.id = String(id)
        self.name = name
        self.artistName = artistName
        self.price = String(price)
        self.currency = currency
        self.artworkUrl = artworkUrl
    }
    
}
