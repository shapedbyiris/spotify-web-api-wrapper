//
//  Models.swift
//  HTTPClient
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public struct Album {
    public let name: String
    public let spotifyArtists: [Artist]
    public let spotifyID: String
}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyArtists = "artists"
        case spotifyID = "id"
    }
}

public struct Artist {
    public let name: String
    public let spotifyID: String
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyID = "id"
    }
}
