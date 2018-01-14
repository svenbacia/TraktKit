//
//  SeasonResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class SeasonResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testSeasons() {
        let resource = trakt.resources.show(112663).seasons(.full)
        let data = buildJsonData(name: "show-seasons")
        let seasons = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/112663/seasons?extended=full")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(seasons.count, 2)
    }

    func testSeasonsWithEpisodes() {
        let resource = trakt.resources.show(112663).seasons(.episodes)
        let data = buildJsonData(name: "show-seasons-episodes")
        let seasons = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/112663/seasons?extended=episodes")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(seasons.count, 2)
        XCTAssertEqual(seasons.first!.episodes!.count, 18)
        XCTAssertEqual(seasons.last!.episodes!.count, 9)
    }

    func testSummary() {
        let resource = trakt.resources.show(107717).season(1).summary()
        let data = buildJsonData(name: "show-season-summary")
        let episodes = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(episodes.count, 18)
    }

    func testComments() {
        let resource = trakt.resources.show(107717).season(1).comments()
        let data = buildJsonData(name: "show-season-comments")
        let comments = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/comments")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(comments.count, 4)
    }

    func testRatings() {
        let resource = trakt.resources.show(107717).season(1).ratings()
        let data = buildJsonData(name: "show-season-ratings")
        let rating = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/ratings")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(rating.votes, 131)
        XCTAssertEqual(rating.rating, 8.43511, accuracy: Double.ulpOfOne)
    }

    func testStats() {
        let resource = trakt.resources.show(107717).season(1).stats()
        let data = buildJsonData(name: "show-season-stats")
        let stats = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/stats")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(stats.collectedEpisodes, 1164081)
        XCTAssertEqual(stats.collectors, 90781)
        XCTAssertEqual(stats.comments, 4)
        XCTAssertEqual(stats.lists, 84)
        XCTAssertEqual(stats.plays, 962286)
        XCTAssertEqual(stats.watchers, 60369)
    }

    func testWatching() {
        let resource = trakt.resources.show(107717).season(1).watching()
        let data = buildJsonData(name: "show-season-watching")
        let watching = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/watching")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(watching.count, 4)
    }
}
