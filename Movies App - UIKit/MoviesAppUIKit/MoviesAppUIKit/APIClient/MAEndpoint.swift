//
//  MAEndpoint.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum MAEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get movies list
    case movieSearch = "SearchMovie"
    /// Endpoint to get movie rating
    case movieRating = "Ratings"
    /// Endpoint to get movie detail
    case movieDetails = "Title"
}
