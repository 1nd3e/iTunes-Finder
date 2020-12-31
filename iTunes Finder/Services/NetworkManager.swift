//
//  NetworkManager.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 27.12.2020.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Types
    
    typealias CompletionBlock = (Data?, Error?) -> Void
    
    // MARK: - Methods
    
    // Loads data from network at specified URL.
    func request(endpoint url: String, completion: @escaping CompletionBlock) {
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            completion(data, error)
        }
        
        dataTask.resume()
    }
    
}
