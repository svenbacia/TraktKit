//
//  ContentItemTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 02.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
@testable import TraktKit

class ContentItemTests: XCTestCase {

    func testMovies() {
        let movie = ContentItem.movie(id: 123)
        let json = movie.asJSON
        let ids = json["ids"] as! [String: Any]
        XCTAssertEqual(ids["trakt"] as! Int, 123)
    }

    func testShows() {
        let show = ContentItem.show(id: 234)
        let json = show.asJSON
        let ids = json["ids"] as! [String: Any]
        XCTAssertEqual(ids["trakt"] as! Int, 234)
    }

    func testSeasons() {
        let seasons = ContentItem.season(numbers: [1, 2], show: 345)
        let json = seasons.asJSON
        let seasonsJSON = json["seasons"] as! [[String: Any]]
        XCTAssertEqual(json["ids"] as! Int, 345)
        XCTAssertEqual(seasonsJSON.count, 2)
        XCTAssertNotNil(seasonsJSON.first!["number"] as! Int)
        XCTAssertNotNil(seasonsJSON.last!["number"] as! Int)
    }

    func testEpisode() {
        let item = ContentItem.episode(id: 1)
        let json = item.asJSON
        let ids = json["ids"] as! [String: Any]
        XCTAssertEqual(ids["trakt"] as! Int, 1)
    }

    func testEpisodes() {
        let item = ContentItem.episodes(numbers: [1, 2, 3], season: 5, show: 987)
        let json = item.asJSON
        let seasons = json["seasons"] as! [String: Any]
        let episodes = seasons["episodes"] as! [[String: Any]]
        XCTAssertEqual(json["ids"] as! Int, 987)
        XCTAssertEqual(seasons["number"] as! Int, 5)
        XCTAssertEqual(episodes.count, 3)
        XCTAssertNotNil(episodes.first!["number"] as! Int)
    }

    func testPerson() {
        let item = ContentItem.person(name: "Name", id: 159)
        let json = item.asJSON
        let ids = json["ids"] as! [String: Any]
        XCTAssertEqual(json["name"] as! String, "Name")
        XCTAssertEqual(ids["trakt"] as! Int, 159)
    }
}
