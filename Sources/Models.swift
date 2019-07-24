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
}

public struct Artist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyURI = "uri"
    }
}

public struct Album: SpotifyEntity {
    public let name: String
    public let spotifyArtists: [Artist]
    public let spotifyURI: String
}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyArtists = "artists"
        case spotifyURI = "uri"
    }
}

public struct Playlist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
}

extension Playlist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyURI = "uri"
    }
}

public struct Track: SpotifyEntity {
    public let title: String
    public let artists: [Artist]
    public let album: Album
    private let miliseconds: Int
    public let spotifyURI: String

    public var duration: TimeInterval {
        return TimeInterval(miliseconds) / 1000.0
    }
}

extension Track: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case artists
        case album
        case miliseconds = "duration_ms"
        case spotifyURI = "uri"
    }
}
