//
//  MARequest.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

/// A class that encapsulates all the details necessary to construct an HTTP request, including the URL, HTTP method, headers, and any query or body parameters. This class is used by the MAService to initiate network requests.
final class MARequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://imdb-api.com"
        static let apiKey = "k_q0vpw8zr"
    }
    
    /// Desired endpoint
    let endpoint: MAEndpoint
    
    /// Path components for API, if any
    private let pathComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        
        var languageCode = "en"
        
        //get the cell phone language set
        if let preferredLanguage = Locale.preferredLanguages.first {
            languageCode =  String(preferredLanguage.prefix(2))
        }
        
        
        var string = Constants.baseUrl
        string += "/"
        string += "\(languageCode)/API/"
        string += endpoint.rawValue
        string += "/"
        string += Constants.apiKey
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
                
        if !queryParameters.isEmpty {
            string += "&"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }

    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: MAEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Attempt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let maEndpoint = MAEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: maEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                
                if let maEndpoint = MAEndpoint(rawValue: endpointString) {
                    self.init(endpoint: maEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
}

// MARK: - Request convenience

extension MARequest {
    static let listMostPopularMoviesRequests = MARequest(endpoint: .mostPopularMovies)
}
