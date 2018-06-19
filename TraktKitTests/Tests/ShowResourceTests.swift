//
//  ShowResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class ShowResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testSummary() throws {
        let resource = trakt.resources.show(107717).summary()
        let data = buildJsonData(name: "show-summary")
        let show = try resource.parse(data)
        XCTAssertEqual(show.ids.trakt, 107717)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717")
    }

    func testComments() throws {
        let resource = trakt.resources.show(107717).comments()
        let data = buildJsonData(name: "show-comments")
        let comments = try resource.parse(data)
        XCTAssertEqual(comments.count, 10)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/comments")
    }

    func testPeople() throws {
        let resource = trakt.resources.show(107717).people()
        let data = buildJsonData(name: "show-people")
        let people = try resource.parse(data)
        XCTAssertEqual(people.cast.count, 9)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/people")
    }

    func testRatings() throws {
        let resource = trakt.resources.show(107717).ratings()
        let data = buildJsonData(name: "show-ratings")
        let rating = try resource.parse(data)
        XCTAssertEqual(rating.votes, 1184)
        XCTAssertEqual(rating.rating, 8.20439, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/ratings")
    }

    func testRelated() throws {
        let resource = trakt.resources.show(107717).related()
        let data = buildJsonData(name: "show-related")
        let related = try resource.parse(data)
        XCTAssertEqual(related.count, 10)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/related")
    }

    func testStats() throws {
        let resource = trakt.resources.show(107717).stats()
        let data = buildJsonData(name: "show-stats")
        let stats = try resource.parse(data)
        XCTAssertEqual(stats.collectedEpisodes, 1125190)
        XCTAssertEqual(stats.collectors, 85640)
        XCTAssertEqual(stats.comments, 27)
        XCTAssertEqual(stats.lists, 25045)
        XCTAssertEqual(stats.plays, 1030596)
        XCTAssertEqual(stats.watchers, 58359)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/stats")
    }

    func testWatching() throws {
        let resource = trakt.resources.show(107717).watching()
        let data = buildJsonData(name: "show-watching")
        let watching = try resource.parse(data)
        XCTAssertEqual(watching.count, 10)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/watching")
    }
}
