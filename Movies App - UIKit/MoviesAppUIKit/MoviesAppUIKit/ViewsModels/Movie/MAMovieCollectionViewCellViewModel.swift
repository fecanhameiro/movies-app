//
//  MAMovieCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

/// A ViewModel class that prepares and manages the data required for displaying a movie in the MAMovieCollectionViewCell.
final class MAMovieCollectionViewCellViewModel: Hashable, Equatable {
    public let movieId: String
    public let movieTitle: String
    public let movieImageUrl: URL?
    public var rating: MARating? = nil
    
    // MARK: - Init
    
    init(
        movieId: String,
        movieTitle: String,
        movieImageUrl: URL?,
        rating: MARating? = nil
    ) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        self.movieImageUrl = movieImageUrl
        self.rating = rating
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = movieImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        MAImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    public func fetchRating(completion: @escaping (Result<MARating, Error>) -> Void) {

        let request = MARequest(endpoint: .movieRating, pathComponents: [self.movieId])
                
        MAService.shared.execute(request, expecting: MARating.self) { result in
            switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let failure):
                    completion(.failure(failure ))
            }
        }
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
