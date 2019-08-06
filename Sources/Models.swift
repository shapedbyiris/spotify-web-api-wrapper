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
}

public struct Artist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
    let images: [SpotifyImageContainer]?
    public var thumbnailImageURL: URL? {
        return images?.last?.url
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
    }}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyArtists = "artists"
        case spotifyURI = "uri"
        case images
    }
}

public struct Playlist: SpotifyEntity {
    public let name: String
    public let spotifyURI: String
    let images: [SpotifyImageContainer]?
    public var thumbnailImageURL: URL? {
        return images?.last?.url
    }
}

extension Playlist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyURI = "uri"
        case images
    }
}

public struct Track: SpotifyEntity {
    public let title: String
    public let artists: [Artist]
    public let album: Album?
    private let miliseconds: Int
    public let spotifyURI: String
    public var thumbnailImageURL: URL? {
        return album?.images?.last?.url
    }
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
