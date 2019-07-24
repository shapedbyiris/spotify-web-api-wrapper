//
//  URLRequest+Spotify.swift
//  SpotifyWebAPIWrapper
//
//  Created by Ariel Elkin on 17/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public extension URLRequest {

    private static let spotifyBaseURL = URL(string: "https://api.spotify.com/v1/")

    init(spotifySearch queryString: String, token: String) {
        let suffix = URLComponents.generalSearch(queryString: queryString)
        let completeURL = suffix.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }

    init(my entityType: SpotifyEntity.Type, token: String) {

        var components = URLComponents()

        switch entityType {
        case is Artist.Type:
            components.path = "me/following"
            components.queryItems = [URLQueryItem(name: "type", value: "artist")]
        case is Album.Type:
            components.path = "me/albums"
        case is Track.Type:
            components.path = "me/tracks"
        case is Playlist.Type:
            components.path = "me/playlists"
        default:
            assertionFailure()
        }

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }
}

private func authorisationHeader(token: String) -> [String: String] {
    return ["Authorization": "Bearer \(token)"]
}

private extension String {
    static let GET = "GET"
    static let POST = "POST"
}

private extension URLComponents {
    static func generalSearch(queryString: String) -> URLComponents {
        var components = URLComponents()
        components.path = "search"
        let searchQuery = URLQueryItem(name: "q", value: queryString)
        let queryType = URLQueryItem(name: "type", value: "playlist,artist,album,track")
        components.queryItems = [searchQuery, queryType]
        return components
    }
}
