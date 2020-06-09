//
//  Models.swift
//  SpotifyWebAPIWrapper
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public protocol SpotifyEntity: Codable {
    var spotifyURI: String { get }
    var thumbnailImageURL: URL? { get }
    var largeImageURL: URL? { get }
}

public struct Artist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
    let images: [SpotifyImageContainer]?
    public var thumbnailImageURL: URL? {
        return images?.last?.url
    }
    public var largeImageURL: URL? {
        return images?.first?.url
    }
}

struct SpotifyImageContainer: Codable {
    let url: URL
    let width: Int?
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyURI = "uri"
        case images
    }
}

public struct Album: SpotifyEntity {
    public let name: String
    public let spotifyArtists: [Artist]
    public let spotifyURI: String
    let images: [SpotifyImageContainer]?
    public var thumbnailImageURL: URL? {
        return images?.last?.url
    }
    public var largeImageURL: URL? {
        return images?.first?.url
    }
    private let trackContainer: TrackContainer?

    private struct TrackContainer: Codable {
        let items: [Track]
    }

    public var tracks: [Track]? {
        if let allTracks = trackContainer?.items {
            var newTracks = [Track]()
            for var track in allTracks {
                track.album = self
                newTracks.append(track)
            }
            return newTracks
        }
        return nil
    }
}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyArtists = "artists"
        case spotifyURI = "uri"
        case images
        case trackContainer = "tracks"
    }
}

public struct Playlist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
    public let playlistID: String
    let images: [SpotifyImageContainer]?
    public var thumbnailImageURL: URL? {
        return images?.last?.url
    }
    public var largeImageURL: URL? {
        return images?.first?.url
    }
    public let pagingObject: SpotifyPagingObject<Track>?

    let owner: String
}

extension Playlist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyURI = "uri"
        case playlistID = "id"
        case images
        case pagingObject = "tracks"
        case owner
    }

    public init(from decoder: Decoder) throws {
        let results = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try results.decode(String.self, forKey: .name)
        self.spotifyURI = try results.decode(String.self, forKey: .spotifyURI)
        self.playlistID = try results.decode(String.self, forKey: .playlistID)
        self.images = try? results.decode([SpotifyImageContainer].self, forKey: .images)
        self.pagingObject = try? results.decode(SpotifyPagingObject<Track>.self, forKey: .pagingObject)
        let playlistOwnerContainer = try results.decode(PlaylistOwnerContainer.self, forKey: .owner)
        self.owner = playlistOwnerContainer.display_name ?? playlistOwnerContainer.id
    }
}

struct PlaylistOwnerContainer: Codable {
    let display_name: String? // swiftlint:disable:this identifier_name
    let id: String // swiftlint:disable:this identifier_name
}

public struct Track: SpotifyEntity {
    public let title: String
    public let artists: [Artist]
    public var album: Album?
    private let miliseconds: Int
    public let spotifyURI: String
    public let trackNumber: Int?

    public var thumbnailImageURL: URL? {
        return album?.images?.last?.url
    }
    public var largeImageURL: URL? {
        return album?.images?.first?.url
    }
    public var duration: TimeInterval {
        return TimeInterval(miliseconds) / 1_000.0
    }
}

extension Track: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case artists
        case album
        case miliseconds = "duration_ms"
        case spotifyURI = "uri"
        case trackNumber = "track_number"
    }
}
