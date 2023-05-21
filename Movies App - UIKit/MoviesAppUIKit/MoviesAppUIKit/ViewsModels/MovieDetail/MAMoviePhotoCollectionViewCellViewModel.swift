//
//  MAMoviePhotoCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

/// This ViewModel class prepares and manages the data necessary for the MAMoviePhotoCollectionViewCell, showcasing a movie's photo.
final class MAMoviePhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    public let accessibilityText : String?
    
    init(imageUrl: URL?, accessibilityText : String?) {
        self.imageUrl = imageUrl
        self.accessibilityText = accessibilityText
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        MAImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
