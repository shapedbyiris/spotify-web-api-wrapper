//
//  URLRequest+Spotify.swift
//  SpotifyWebAPIWrapper
//
//  Created by Ariel Elkin on 17/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public extension URLRequest {

    #if DEBUG
    static var spotifyBaseURL: URL {
        if ProcessInfo().arguments.contains("UI-TESTING") {
            return URL(string: "http://localhost:8080")!
        } else {
            return URL(string: "https://api.spotify.com/v1/")!
        }
    }
    #else
    private static let spotifyBaseURL = URL(string: "https://api.spotify.com/v1/")
    #endif

    init(spotifySearch queryString: String, limit: Int = 20, wildCard: Bool = true, token: String) {
        var components = URLComponents()
        components.path = "search"
        let searchQuery = URLQueryItem(name: "q", value: queryString + (wildCard ? "*" : ""))
        let queryType = URLQueryItem(name: "type", value: "playlist,artist,album,track")
        let limit = URLQueryItem(name: "limit", value: "\(limit)")
        components.queryItems = [searchQuery, queryType, limit]

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }

    init(my entityType: SpotifyEntity.Type, limit: Int = 20, token: String) {
        var components = URLComponents()
        var queryItems = [URLQueryItem]()

        switch entityType {
        case is Artist.Type:
            components.path = "me/following"
            queryItems.append(URLQueryItem(name: "type", value: "artist"))
        case is Album.Type:
            components.path = "me/albums"
        case is Track.Type:
            components.path = "me/tracks"
        case is Playlist.Type:
            components.path = "me/playlists"
        default:
            assertionFailure()
        }

        let limit = URLQueryItem(name: "limit", value: "\(limit)")
        queryItems.append(limit)

        components.queryItems = queryItems

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }

    init(topTracksForArtist artistID: String, token: String, country: String = "GB") {
        var components = URLComponents()
        components.path = "artists/\(artistID.entityID)/top-tracks"
        components.queryItems = [URLQueryItem(name: "country", value: country)]

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }

    init(album spotifyURI: String, token: String) {
        var components = URLComponents()
        components.path = "albums/\(spotifyURI.entityID)"

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }

    init(tracksInPlaylist spotifyURI: String, token: String) {
        var components = URLComponents()
        components.path = "playlists/\(spotifyURI.entityID)"

        let completeURL = components.url(relativeTo: URLRequest.spotifyBaseURL)!

        self.init(url: completeURL)

        self.allHTTPHeaderFields = authorisationHeader(token: token)
        self.httpMethod = .GET
    }
}

private extension String {
    var entityID: String {
        let components = self.components(separatedBy: ":")
        if components.count > 1 {
            return components.last!
        } else {
            return self
        }
    }
}

private func authorisationHeader(token: String) -> [String: String] {
    return ["Authorization": "Bearer \(token)"]
}

private extension String {
    static let GET = "GET"
    static let POST = "POST"
}
