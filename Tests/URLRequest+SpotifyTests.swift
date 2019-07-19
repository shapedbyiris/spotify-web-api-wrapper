//
//  URLRequest+SpotifyTests.swift
//  SpotifyClientTests
//
//  Created by Ariel Elkin on 17/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import XCTest

class URLRequestPlusSpotifyTests: XCTestCase {

    let token = "token"

    func testSearchRequestBuildsCorrectly() {

        let duranDuranSearchRequest = URLRequest.init(spotifySearch: "duran duran", token: token)
        XCTAssert(duranDuranSearchRequest.httpMethod == "GET")
        XCTAssert(duranDuranSearchRequest.url == URL(string: "https://api.spotify.com/v1/search?q=duran%20duran&type=playlist,artist,album,track"))
        XCTAssert(duranDuranSearchRequest.allHTTPHeaderFields != nil)
        XCTAssert(duranDuranSearchRequest.allHTTPHeaderFields!.contains(where: {
            $0.key == "Authorization" && $0.value == "Bearer token"
        }))
    }
}
