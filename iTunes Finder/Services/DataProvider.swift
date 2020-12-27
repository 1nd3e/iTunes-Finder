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
    
    typealias AlbumsCompletionBlock = (Result<Array<Album>, Error>) -> Void
    
    // MARK: - Properties
    
    static let shared = DataProvider()
    
    // MARK: - Public Methods
    
    // Requests albums from iTunes for a given search query.
    func getAlbums(term: String, completion: @escaping AlbumsCompletionBlock) {
        let url = "https://itunes.apple.com/search?&term=\(term)&entity=album"
        
        NetworkManager.shared.request(endpoint: url) { [weak self] data, error in
            if let data = data {
                if let albums = self?.parse(albums: data) {
                    completion(.success(albums))
                }
            } else if let error = error {
                completion(.failure(error))
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
