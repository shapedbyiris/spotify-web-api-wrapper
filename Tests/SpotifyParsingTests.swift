//
//  SpotifyParsingTests.swift
//  HTTPClientTests
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import XCTest
@testable import SpotifyWebAPI

class SpotifyParsingTests: XCTestCase {

    static func dataForJSONFileNamed(string: String) -> Data {
        let podBundle = Bundle(for: self.classForCoder())
        let resourceBundleURL = podBundle.url(forResource: "SpotifyWebAPIJSONMocks", withExtension: "bundle")!
        let resourceBundle = Bundle(url: resourceBundleURL)!
        let jsonFileURL = resourceBundle.url(forResource: string, withExtension: "json")!
        let jsonFileData = try! Data(contentsOf: jsonFileURL)
        return jsonFileData
    }

    static let searchResultsData: Data = {
        return dataForJSONFileNamed(string: "search_results_duranduran")
    }()

    static let errorData: Data = {
        return dataForJSONFileNamed(string: "error_token_expired")
    }()

    func testCorrectlyParsesSearchResults() {
        do {
            let results = try JSONDecoder().decode(SpotifySearchResult.self, from: SpotifyParsingTests.searchResultsData)
            XCTAssert(results.albums.count == 20)

            let firstAlbum = results.albums[0]
            XCTAssert(firstAlbum.artists[0].name == "Duran Duran")
            XCTAssert(firstAlbum.artists[0].spotifyID == "0lZoBs4Pzo7R89JM9lxwoT")
            XCTAssert(firstAlbum.name == "Rio [Collector\'s Edition]")
            XCTAssert(firstAlbum.spotifyID == "02tfQwJSOLP77oCd9U8bqm")

            let nineteenthAlbum = results.albums[18]
            XCTAssert(nineteenthAlbum.name == "Sana Doğru")
            XCTAssert(nineteenthAlbum.artists[0].name == "Bora Duran")
            XCTAssert(nineteenthAlbum.artists[0].spotifyID == "0W0qg2fjQVk63h44Zdn4hI")
            XCTAssert(nineteenthAlbum.spotifyID == "5flg28yvPpynO6NVnZV5LH")

            let fifthArtist = results.artists[4]
            XCTAssert(fifthArtist.name == "Tutto Duran")
            XCTAssert(fifthArtist.spotifyID == "6J5DvhqOWQlM4RcdzePXEZ")

            let fifteenthArtist = results.artists[14]
            XCTAssert(fifteenthArtist.name == "Chris Duran")
            XCTAssert(fifteenthArtist.spotifyID == "1cuygaMWRUavQ2vfL4v5ex")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesError() {
        do {
            let error = try JSONDecoder().decode(SpotifyError.self, from: SpotifyParsingTests.errorData)
            XCTAssert(error.message == "The access token expired")
            XCTAssert(error.status == 401)
        } catch {
            XCTFail()
        }
    }
}
