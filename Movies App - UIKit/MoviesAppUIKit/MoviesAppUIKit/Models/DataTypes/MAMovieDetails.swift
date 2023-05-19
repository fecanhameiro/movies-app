//
//  MAMovieDetails.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

struct MAMovieDetails: Codable {
    let id: String
    let title: String
    let originalTitle: String
    let fullTitle: String
    let image: String
    let releaseDate: String
    let plot: String
    let fullCast: MAFullCast?
 
}
