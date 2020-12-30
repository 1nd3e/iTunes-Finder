//
//  Song.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import Foundation

struct Song: ParsableModel {
    
    // MARK: - Properties
    
    let name: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard let name = data["trackCensoredName"] as? String else { return nil }
        self.name = name
    }
    
}
