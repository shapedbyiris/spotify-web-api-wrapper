//
//  URLRequest+SpotifyTests.swift
//  SpotifyWebAPIWrapperTests
//
//  Created by Ariel Elkin on 17/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import XCTest

@testable import SpotifyWebAPI

class URLRequestPlusSpotifyTests: XCTestCase { //swiftlint:disable line_length

    let token = "token"

    func testGeneralSearchRequestBuildsCorrectly() {
        let duranDuranSearchRequest = URLRequest.init(spotifySearch: "duran duran", token: token)
        XCTAssert(duranDuranSearchRequest.httpMethod == "GET")
        XCTAssert(duranDuranSearchRequest.url == URL(string: "https://api.spotify.com/v1/search?q=duran%20duran&type=playlist,artist,album,track&limit=20"))
        XCTAssert(duranDuranSearchRequest.allHTTPHeaderFields != nil)
        XCTAssert(duranDuranSearchRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }

    func testMyArtistsRequestsBuildsCorrectly() {
        let myTracksRequest = URLRequest.init(my: Artist.self, token: "token")
        XCTAssert(myTracksRequest.httpMethod == "GET")
        XCTAssert(myTracksRequest.url == URL(string: "https://api.spotify.com/v1/me/following?type=artist&limit=20"))
        XCTAssert(myTracksRequest.allHTTPHeaderFields != nil)
        XCTAssert(myTracksRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }

    func testMyAlbumsRequestsBuildsCorrectly() {
        let myTracksRequest = URLRequest.init(my: Album.self, token: "token")
        XCTAssert(myTracksRequest.httpMethod == "GET")
        XCTAssert(myTracksRequest.url == URL(string: "https://api.spotify.com/v1/me/albums?limit=20"))
        XCTAssert(myTracksRequest.allHTTPHeaderFields != nil)
        XCTAssert(myTracksRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }

    func testMyPlaylistsRequestsBuildsCorrectly() {
        let myTracksRequest = URLRequest.init(my: Playlist.self, token: "token")
        XCTAssert(myTracksRequest.httpMethod == "GET")
        XCTAssert(myTracksRequest.url == URL(string: "https://api.spotify.com/v1/me/playlists?limit=20"))
        XCTAssert(myTracksRequest.allHTTPHeaderFields != nil)
        XCTAssert(myTracksRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }

    func testMyTracksRequestsBuildsCorrectly() {
        let myTracksRequest = URLRequest.init(my: Track.self, token: "token")
        XCTAssert(myTracksRequest.httpMethod == "GET")
        XCTAssert(myTracksRequest.url == URL(string: "https://api.spotify.com/v1/me/tracks?limit=20"))
        XCTAssert(myTracksRequest.allHTTPHeaderFields != nil)
        XCTAssert(myTracksRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }
}
