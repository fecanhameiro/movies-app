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
    case movieSearch = "SearchMovie"
}
