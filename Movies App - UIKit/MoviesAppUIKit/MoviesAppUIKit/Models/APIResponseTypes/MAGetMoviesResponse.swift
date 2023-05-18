//
//  MAGetMoviesResponse.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

struct MAGetMoviesResponse: Codable {
    let page: Int
    let results: [MAMovie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
