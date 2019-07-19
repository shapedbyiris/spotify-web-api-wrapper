//
//  SpotifyAPI.swift
//  HTTPClient
//
//  Created by Ariel Elkin on 19/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public struct SpotifyError: Codable, Error {
    var message: String {
        return error.message
    }
    var status: Int {
        return error.status
    }

    private let error: Container
    private struct Container: Codable {
        let message: String
        let status: Int
    }
}

public struct SpotifySearchResult: Codable {
    let albums: [Album]
    let artists: [Artist]

    private struct SpotifyPagingObject<T: Codable>: Codable {
        let items: [T]
    }

    public init(from decoder: Decoder) throws {
        let results = try decoder.container(keyedBy: CodingKeys.self)

        let albumsContainer = try results.decode(SpotifyPagingObject<Album>.self, forKey: .albums)
        albums = albumsContainer.items

        let artistsContainer = try results.decode(SpotifyPagingObject<Artist>.self, forKey: .artists)
        artists = artistsContainer.items
    }
}
