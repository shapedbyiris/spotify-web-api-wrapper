//
//  SpotifyParsingTests.swift
//  SpotifyWebAPIWrapperTests
//
//  Created by Ariel Elkin on 18/07/2019.
//  Copyright © 2019 IRIS. All rights reserved.
//
//swiftlint:disable force_try line_length

import XCTest
import Foundation
@testable import SpotifyWebAPI

class SpotifyParsingTests: XCTestCase {

    func testCorrectlyParsesMyTracks() {
        do {
            let url: URL = Bundle.module.url(forResource: "my_tracks", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(SpotifyPagingObject<Track>.self, from: data)

            let firstTrack = results.items[0]
            XCTAssert(firstTrack.title == "Timewarp")
            XCTAssert(firstTrack.artists[0].name == "Emapea")
            XCTAssert(firstTrack.album!.name == "Seeds, Roots & Fruits")
            XCTAssert(firstTrack.thumbnailImageURL!.absoluteString == "https://i.scdn.co/image/486396acc04b67827547a263ccdb78a19a754a42")
            let thirdTrack = results.items[2]
            XCTAssert(thirdTrack.title == "Temple")
            XCTAssert(thirdTrack.album!.name == "Temple")
            XCTAssert(thirdTrack.artists[0].name == "Jan Jelinek")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesMyArtists() {
        do {
            let url: URL = Bundle.module.url(forResource: "my_artists", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(SpotifyPagingObject<Artist>.self, from: data)

            let firstArtist = results.items[0]
            XCTAssert(firstArtist.name == "Charlie Byrd")
            XCTAssert(firstArtist.thumbnailImageURL!.absoluteString == "https://i.scdn.co/image/f6c4543ca9c7307a9ec840fd29fdd60372b119a4")

            let secondArtist = results.items[1]
            XCTAssert(secondArtist.name == "The New Mastersounds")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesMyAlbums() {
        do {
            let url: URL = Bundle.module.url(forResource: "my_albums", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(SpotifyPagingObject<Album>.self, from: data)

            let firstAlbum = results.items[0]
            XCTAssert(firstAlbum.name == "Out On the Faultline")
            XCTAssert(firstAlbum.spotifyArtists[0].name == "The New Mastersounds")
            XCTAssert(firstAlbum.thumbnailImageURL!.absoluteString == "https://i.scdn.co/image/edb93932af6ae201f416e0c6f76e0f2d74f39d9f")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesMyPlaylists() {
        do {
            let url: URL = Bundle.module.url(forResource: "my_playlists", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(SpotifyPagingObject<Playlist>.self, from: data)

            let firstPlaylist = results.items[0]
            XCTAssert(firstPlaylist.name == "Good glitches")
            XCTAssert(firstPlaylist.images?.first?.url.absoluteString == "https://i.scdn.co/image/c7f378927781b68fe14e67cfa6b9e16a139bf4bd")

            let secondPlaylist = results.items[1]
            XCTAssert(secondPlaylist.name == "Danceahll")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesTopTracks() {
        do {
            let url: URL = Bundle.module.url(forResource: "artist_top_tracks", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(TrackList.self, from: data)

            let firstTrack = results.tracks[0]
            XCTAssert(firstTrack.title == "Can't Help Falling in Love")
            XCTAssert(firstTrack.artists[0].name == "Elvis Presley")
            XCTAssert(firstTrack.album!.name == "Blue Hawaii")

            let eigthTrack = results.tracks[7]
            XCTAssert(eigthTrack.artists[0].name == "Elvis Presley")
            XCTAssert(eigthTrack.title == "Blue Suede Shoes")
            XCTAssert(eigthTrack.duration == 119.2)

        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesPlaylist() {
        do {
            let url: URL = Bundle.module.url(forResource: "playlist", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(Playlist.self, from: data)

            guard let firstTrack = results.pagingObject?.items[0] else {
                return XCTFail("first track is nil")
            }
            XCTAssert(firstTrack.title == "Yellow Ledbetter")
            XCTAssert(firstTrack.artists[0].name == "Pearl Jam")
            XCTAssert(firstTrack.album!.name == "Jeremy")

            guard let eigthTrack = results.pagingObject?.items[7] else {
                return XCTFail("eigthTrack is nil")
            }
            XCTAssert(eigthTrack.artists[0].name == "Audioslave")
            XCTAssert(eigthTrack.title == "Be Yourself")
            XCTAssert(eigthTrack.album!.name == "Out of Exile")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesTracksInAlbum() {
        do {
            let url: URL = Bundle.module.url(forResource: "tracks_in_album", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(Album.self, from: data)

            guard let secondTrack = results.tracks?[1] else {
                return XCTFail("expecting track at index 1")
            }
            XCTAssert(secondTrack.title == "Rock In The Video Age")
            XCTAssert(secondTrack.duration == 483.973)
            XCTAssert(secondTrack.artists[0].name == "Jan Jelinek")
            XCTAssert(secondTrack.thumbnailImageURL?.absoluteString == "https://i.scdn.co/image/df598f8b015a0b4d663a8598acc1b7aab3a252be")

            guard let fourthTrack = results.tracks?[3] else {
                return XCTFail("expecting track at index 3")
            }
            XCTAssert(fourthTrack.title == "Them, Their")
            XCTAssert(fourthTrack.duration == 306.253)
            XCTAssert(fourthTrack.artists[0].name == "Jan Jelinek")
            XCTAssert(secondTrack.thumbnailImageURL?.absoluteString == "https://i.scdn.co/image/df598f8b015a0b4d663a8598acc1b7aab3a252be")

        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testCorrectlyParsesSearchResults() {
        do {
            let url: URL = Bundle.module.url(forResource: "search_results_duranduran", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let results = try JSONDecoder().decode(SpotifySearchResult.self, from: data)
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
            XCTAssert(fourthTrack.artists.first!.name == "Duran Duran")

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
            let url: URL = Bundle.module.url(forResource: "error_token_expired", withExtension: "json")!
            let data = try! Data(contentsOf: url)

            let error = try JSONDecoder().decode(SpotifyError.self, from: data)
            XCTAssert(error.message == "The access token expired")
            XCTAssert(error.status == 401)
        } catch {
            XCTFail("Error should parse without fail")
        }
    }
}
