//
//  MAGetMostPopularMoviesResponse.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 20/05/23.
//

import Foundation

struct MAGetMostPopularMoviesResponse: Codable {
    let items: [MAMovie]
    let errorMessage: String
}
