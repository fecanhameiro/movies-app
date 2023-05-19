//
//  MAMovieCastCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import UIKit


final class MAMovieCastCollectionViewCellViewModel {
    
    public let borderColor: UIColor
    
    public var title: String?
    public var name: String?
    public var castImageUrl: URL?
    // MARK: - Init
    
    init(title: String?, name: String?, castImageUrl: URL?) {
        self.borderColor = .systemBlue
        self.title = title
        self.name = name
        self.castImageUrl = castImageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = castImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        MAImageLoader.shared.downloadImage(url, completion: completion)
    }

}
