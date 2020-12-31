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
    typealias SongsCompletionBlock = (Result<Array<Song>, Error>) -> Void
    
    // MARK: - Public Properties
    
    static let shared = DataProvider()
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager()
    
    // MARK: - Public Methods
    
    // Requests albums from iTunes for a given search query.
    func get(albumsWithName albumName: String, completion: @escaping AlbumsCompletionBlock) {
        let url = "https://itunes.apple.com/search?&term=\(albumName)&entity=album"
        
        networkManager.request(endpoint: url) { [weak self] data, error in
            if let data = data, let albums = self?.parse(data: data, ofType: Album.self) {
                completion(.success(albums))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    // Requests a list of songs of album.
    func get(songsWithAlbumId albumId: String, completion: @escaping SongsCompletionBlock) {
        let url = "https://itunes.apple.com/lookup?id=\(albumId)&entity=song"
        
        networkManager.request(endpoint: url) { [weak self] data, error in
            if let data = data, let songs = self?.parse(data: data, ofType: Song.self) {
                completion(.success(songs))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    
    // Parses a data into an array of data with type.
    private func parse<T: ParsableModel>(data: Data, ofType: T.Type) -> [T]? {
        guard let json = try? JSON(data: data), let results = json["results"].arrayObject else { return nil }
        var parsedData = [T]()
        
        for data in results {
            if let data = data as? Dictionary<String, Any>, let parsedItem = T(data: data) {
                parsedData.append(parsedItem)
            }
        }
        
        return parsedData
    }
    
}
