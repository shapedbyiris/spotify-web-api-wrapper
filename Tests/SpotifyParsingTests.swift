//
//  SpotifyParsingTests.swift
//  HTTPClientTests
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//

import XCTest

@testable import SpotifyWebAPI

class SpotifyParsingTests: XCTestCase { //swiftlint:disable force_try line_length

    static func dataForJSONFileNamed(string: String) -> Data {

        let podBundle = Bundle(for: self.classForCoder())
        if let resourceBundleURL = podBundle.url(forResource: "SpotifyWebAPIJSONMocks", withExtension: "bundle") {
            // find mock JSON files if bundled using Cocoapods:
            let bundle = Bundle(url: resourceBundleURL)!
            let jsonFileURL = bundle.url(forResource: string, withExtension: "json")!
            let jsonFileData = try! Data(contentsOf: jsonFileURL)
            return jsonFileData
        } else {
            // find mock JSON files if using Swift Package Manager:
            let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            let fileURL = currentDirectoryURL
                .appendingPathComponent("Tests", isDirectory: true)
                .appendingPathComponent("JSONMocks", isDirectory: true)
                .appendingPathComponent(string)
                .appendingPathExtension("json")
            let jsonFileData = try! Data(contentsOf: fileURL)
            return jsonFileData
        }
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

            let fifthArtist = results.artists[4]
            XCTAssert(fifthArtist.name == "Tutto Duran")
            XCTAssert(fifthArtist.spotifyURI == "spotify:artist:6J5DvhqOWQlM4RcdzePXEZ")

            let fifteenthArtist = results.artists[14]
            XCTAssert(fifteenthArtist.name == "Chris Duran")
            XCTAssert(fifteenthArtist.spotifyURI == "spotify:artist:1cuygaMWRUavQ2vfL4v5ex")

            let firstAlbum = results.albums[0]
            XCTAssert(firstAlbum.spotifyArtists[0].name == "Duran Duran")
            XCTAssert(firstAlbum.spotifyArtists[0].spotifyURI == "spotify:artist:0lZoBs4Pzo7R89JM9lxwoT")
            XCTAssert(firstAlbum.name == "Rio [Collector\'s Edition]")
            XCTAssert(firstAlbum.spotifyURI == "spotify:album:02tfQwJSOLP77oCd9U8bqm")

            let nineteenthAlbum = results.albums[18]
            XCTAssert(nineteenthAlbum.name == "Sana Doğru")
            XCTAssert(nineteenthAlbum.spotifyArtists[0].name == "Bora Duran")
            XCTAssert(nineteenthAlbum.spotifyArtists[0].spotifyURI == "spotify:artist:0W0qg2fjQVk63h44Zdn4hI")
            XCTAssert(nineteenthAlbum.spotifyURI == "spotify:album:5flg28yvPpynO6NVnZV5LH")

            let fourthTrack = results.tracks[3]
            XCTAssert(fourthTrack.title == "Rio - 2009 Remaster")
            XCTAssert(fourthTrack.duration == 337.333)
            XCTAssert(fourthTrack.artist.first!.name == "Duran Duran")

            let eighteenthTrack = results.tracks[17]
            XCTAssert(eighteenthTrack.duration == 209.546)
            XCTAssert(eighteenthTrack.spotifyURI == "spotify:track:5pIaAkHJ928V2LGCz79FgQ")
            XCTAssert(eighteenthTrack.title == "Hungry Like the Wolf")

            let firstPlaylist = results.playlists[0]
            XCTAssert(firstPlaylist.name == "This Is Duran Duran")
            XCTAssert(firstPlaylist.spotifyURI == "spotify:playlist:37i9dQZF1DZ06evO08KRgY")

            let twelthPlaylist = results.playlists[11]
            XCTAssert(twelthPlaylist.name == "Duran Duran - Live")
            XCTAssert(twelthPlaylist.spotifyURI == "spotify:playlist:3gtOqKAvvCPzzLJIWc3Emb")

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
            XCTFail("Error should parse without fail")
        }
    }
}
