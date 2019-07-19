//
//  URLRequest+Spotify.swift
//  SpotifyClient
//
//  Created by Ariel Elkin on 17/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public extension URLRequest {

    private static var spotifyBaseURL = URL(string: "https://api.spotify.com/v1/")

    private func headers(token: String) -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }

    init(spotifySearch queryString: String, token: String) {
        let suffix = URLComponents.searchQuery(queryString: queryString)
        let completeURL = suffix.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = headers(token: token)
        self.httpMethod = .GET
    }
}

private extension String {
    static let GET = "GET"
    static let POST = "POST"
}

private extension URLComponents {
    static func searchQuery(queryString: String) -> URLComponents {
        var components = URLComponents()
        components.path = "search"
        let searchQuery = URLQueryItem(name: "q", value: queryString)
        let queryType = URLQueryItem(name: "type", value: "playlist,artist,album,track")
        components.queryItems = [searchQuery, queryType]
        return components
    }
}
