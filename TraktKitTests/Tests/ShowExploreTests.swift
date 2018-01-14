//
//  ShowExploreTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class ShowExploreResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testTrending() {
        let resource = trakt.resources.explore.shows.trending()
        let data = buildJsonData(name: "shows-trending")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/trending")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }

    func testPopular() {
        let resource = trakt.resources.explore.shows.popular()
        let data = buildJsonData(name: "shows-popular")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/popular")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }

    func testAnticipated() {
        let resource = trakt.resources.explore.shows.anticipated()
        let data = buildJsonData(name: "shows-anticipated")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/anticipated")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }

    func testPlayed() {
        let resource = trakt.resources.explore.shows.played()
        let data = buildJsonData(name: "shows-played")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/played")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }

    func testWatched() {
        let resource = trakt.resources.explore.shows.watched()
        let data = buildJsonData(name: "shows-watched")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/watched")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }

    func testCollected() {
        let resource = trakt.resources.explore.shows.collected()
        let data = buildJsonData(name: "shows-collected")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/collected")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.count, 10)
    }
}
