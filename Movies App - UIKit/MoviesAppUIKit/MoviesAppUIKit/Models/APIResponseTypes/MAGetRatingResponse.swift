//
//  MAGetRatingResponse.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

struct MAGetRatingResponse: Codable {
    let rating: MARating
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case  errorMessage
        case rating = "ratingDetails"
    }
}
