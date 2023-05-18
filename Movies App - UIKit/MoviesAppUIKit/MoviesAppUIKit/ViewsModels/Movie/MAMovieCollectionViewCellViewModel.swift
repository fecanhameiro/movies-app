//
//  MAMovieCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

final class MAMovieCollectionViewCellViewModel: Hashable, Equatable {
    public let movieTitle: String
    private let movieImageUrl: URL?
    
    // MARK: - Init
    
    init(
        movieTitle: String,
        movieImageUrl: URL?
    ) {
        self.movieTitle = movieTitle
        self.movieImageUrl = movieImageUrl
    }
    

    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = movieImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        MAImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    
    static func == (lhs: MAMovieCollectionViewCellViewModel, rhs: MAMovieCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieTitle)
        hasher.combine(movieImageUrl)
    }
}
