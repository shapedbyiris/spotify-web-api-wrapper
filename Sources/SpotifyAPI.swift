//
//  SpotifyAPI.swift
//  SpotifyWebAPIWrapper
//
//  Created by Ariel Elkin on 19/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public struct SpotifyError: Codable, Error {
    public var message: String {
        return error.message
    }
    public var status: Int {
        return error.status
    }

    private let error: Container

    private struct Container: Codable {
        let message: String
        let status: Int
    }
}

public struct SpotifyPagingObject<T: SpotifyEntity>: Codable {
    public let items: [T]

    private struct AlbumContainer: Codable {
        let album: Album
    }
    private struct TrackContainer: Codable {
        let track: Track
    }
    private struct ArtistContainer: Codable {
        let items: [Artist]
    }

    private let artists: ArtistContainer? = nil

    //swiftlint:disable force_cast
    public init(from decoder: Decoder) throws {
        let results = try decoder.container(keyedBy: CodingKeys.self)

        if let allThings = try? results.decode([T].self, forKey: .items) {
            items = allThings
        } else if let albumArray = try? results.decode([AlbumContainer].self, forKey: .items) {
            items = albumArray.map { $0.album } as! [T]
        } else if let trackArray = try? results.decode([TrackContainer].self, forKey: .items) {
            items = trackArray.map { $0.track } as! [T]
        } else if let artists = try? results.decode(ArtistContainer.self, forKey: .artists) {
            items = artists.items as! [T]
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.items], debugDescription: "couldn't find items")
            throw DecodingError.valueNotFound(SpotifyEntity.self, context)
        }
    }
    //swiftlint:enable force_cast
}

public struct TrackList: Codable {
    public let tracks: [Track]
}

public struct SpotifySearchResult: Codable {
    public let albums: [Album]
    public let artists: [Artist]
    public let tracks: [Track]
    public let playlists: [Playlist]

    public init(from decoder: Decoder) throws {
        let results = try decoder.container(keyedBy: CodingKeys.self)

        let artistsContainer = try results.decode(SpotifyPagingObject<Artist>.self, forKey: .artists)
        artists = artistsContainer.items

        let albumsContainer = try results.decode(SpotifyPagingObject<Album>.self, forKey: .albums)
        albums = albumsContainer.items

        let tracksContainer = try results.decode(SpotifyPagingObject<Track>.self, forKey: .tracks)
        tracks = tracksContainer.items

        let playlistContainer = try results.decode(SpotifyPagingObject<Playlist>.self, forKey: .playlists)
        playlists = playlistContainer.items
    }
}

public struct SpotifyUserPlaylistsResults: Codable {
    public let items: [Playlist]
}
