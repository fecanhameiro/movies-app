//
//  MAEndpoint.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum MAEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get movies info
    case movieSearch = "search/movie"
}

struct Constants {
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500/"
}
