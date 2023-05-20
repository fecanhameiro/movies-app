//
//  MAMovieCastCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import UIKit

/// A ViewModel class that handles the data for the MAMovieFullCastCollectionViewCell, showcasing the full cast of a movie.
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
    
}
