//
//  MAMovieInfoCollectionViewCellViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import UIKit

/// A ViewModel class responsible for preparing and managing the data needed for the MAMovieInfoCollectionViewCell, which displays detailed movie information.
final class MAMovieInfoCollectionViewCellViewModel {
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.timeZone = .current
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate:  "yyyy-MM-dd", options: 0, locale: Locale.current)
        return formatter
    }()
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "-" }
        
        if let date = Self.dateFormatter.date(from: value),
           type == .releaseDate {
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case title
        case releaseDate
        
        var tintColor: UIColor {
            switch self {
                case .title:
                    return .systemBlue
                case .releaseDate:
                    return .systemRed
            }
        }
        
        var iconImage: UIImage? {
            switch self {
                case .title:
                    return UIImage(systemName: "tv.circle")
                case .releaseDate:
                    return UIImage(systemName: "calendar")
                    
            }
        }
        
        var displayTitle: String {
            switch self {
                case .title:
                    return "movie-details-title".localized()
                case .releaseDate:
                    return "movie-details-release-date".localized()
                    
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}
