//
//  MusicMetadataModels.swift
//  HTTPClient
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import Foundation

public struct Album {
    let name: String
    let artists: [Artist]
    let spotifyID: String?
}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case artists
        case spotifyID = "id"
    }
}

public struct Artist {
    let name: String
    let spotifyID: String?
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case spotifyID = "id"
    }
}
