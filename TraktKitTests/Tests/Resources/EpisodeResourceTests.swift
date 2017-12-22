//
//  EpisodeResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class EpisodeResourceTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()
    
    // MARK: - Tests
    
    func testSummary() {
        let resource = trakt.resources.show(107717).season(1).episode(1).summary()
        let data = buildJsonData(name: "episode-summary")
        let episode = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/episodes/1")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(episode.title, "Pilot")
    }
    
    func testComments() {
        let resource = trakt.resources.show(107717).season(1).episode(1).comments()
        let data = buildJsonData(name: "episode-comments")
        let comments = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/episodes/1/comments")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(comments.count, 8)
    }
    
    func testRatings() {
        let resource = trakt.resources.show(107717).season(1).episode(1).ratings()
        let data = buildJsonData(name: "episode-ratings")
        let rating = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/episodes/1/ratings")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(rating.votes, 4977)
        XCTAssertEqual(rating.rating, 7.81234, accuracy: Double.ulpOfOne)
    }
    
    func testStats() {
        let resource = trakt.resources.show(107717).season(1).episode(1).stats()
        let data = buildJsonData(name: "episode-stats")
        let stats = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/episodes/1/stats")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertNil(stats.collectedEpisodes)
        XCTAssertEqual(stats.collectors, 75651)
        XCTAssertEqual(stats.comments, 8)
        XCTAssertEqual(stats.lists, 310)
        XCTAssertEqual(stats.plays, 67078)
        XCTAssertEqual(stats.watchers, 50308)
    }
    
    func testWatching() {
        let resource = trakt.resources.show(107717).season(1).episode(1).watching()
        let data = buildJsonData(name: "episode-watching")
        let watching = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/seasons/1/episodes/1/watching")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(watching.count, 9)
    }
}
