//
//  MAGetMoviesResponse.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

struct MAGetMoviesResponse: Codable {
    let searchType: String
    let results: [MAMovie]
    let errorMessage: String
}
