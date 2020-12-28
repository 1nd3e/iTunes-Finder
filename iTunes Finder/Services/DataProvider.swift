//
//  DataProvider.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 27.12.2020.
//

import Foundation
import SwiftyJSON

final class DataProvider {
    
    // MARK: - Types
    
    typealias AlbumsCompletionBlock = (Array<Album>) -> Void
    
    // MARK: - Properties
    
    static let shared = DataProvider()
    
    // MARK: - Public Methods
    
    // Requests albums from iTunes for a given search query.
    func get(albumsWithName albumName: String, completion: @escaping AlbumsCompletionBlock) {
        let url = "https://itunes.apple.com/search?&term=\(albumName)&entity=album"
        
        NetworkManager.shared.request(endpoint: url) { [weak self] data in
            if let data = data, let albums = self?.parse(albums: data) {
                completion(albums)
            }
        }
    }
    
    // MARK: - Private Methods
    
    // Parses a data into an array of albums.
    private func parse(albums data: Data) -> [Album]? {
        guard let json = try? JSON(data: data), let results = json["results"].arrayObject else { return nil }
        var albums = [Album]()
        
        for data in results {
            if let data = data as? Dictionary<String, Any>, let album = Album(data: data) {
                albums.append(album)
            }
        }
        
        return albums
    }
    
}
