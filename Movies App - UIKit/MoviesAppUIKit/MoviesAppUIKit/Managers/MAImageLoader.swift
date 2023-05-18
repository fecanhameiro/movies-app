//
//  MAImageLoader.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

/// Manage for image loading
final class MAImageLoader {
    /// Shared instance
    static let shared = MAImageLoader()
    
    /// In memory data cache
    private var imageDataCache = NSCache<NSString, NSData>()
    
    /// Constructor
    private init() {}
    
    /// Get image content with URl
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data)) // NSData == Data | NSString == String
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
