//
//  MAMoviePlotCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

/// A ViewModel class that prepares and manages the data needed for the MAMoviePlotCollectionViewCell, which displays a movie's plot.
final class MAMoviePlotCollectionViewCellViewModel {
    public let text: String?
    
    init(text: String?) {
        self.text = text
    }

}

