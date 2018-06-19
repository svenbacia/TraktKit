//
//  SyncResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 22.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class SyncResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testLastActivites() throws {
        let resource = trakt.resources.sync.lastActivities()
        let data = buildJsonData(name: "sync-last-activities")
        let activities = try resource.parse(data)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/last_activities")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertNotNil(activities.all)
    }

    func testCollection() throws {
        let resource = trakt.resources.sync.collection()
        let data = buildJsonData(name: "sync-collection-shows")
        let items = try resource.parse(data)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/collection/shows")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(items.count, 4)
    }

    func testWatched() throws {
        let resource = trakt.resources.sync.watched()
        let data = buildJsonData(name: "sync-watched-shows")
        let items = try resource.parse(data)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/watched/shows")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(items.count, 26)
    }

    func testWatchlist() throws {
        let resource = trakt.resources.sync.watchlist()
        let data = buildJsonData(name: "sync-watchlist-shows")
        let items = try resource.parse(data)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/watchlist/shows")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(items.count, 3)
    }

    func testAddToHistory() throws {
        let item = ContentItem.show(id: 1)
        let resource = trakt.resources.sync.addToHistory([item])
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/history")
        XCTAssertEqual(resource.request.httpMethod, "POST")
    }

    func testRemoveFromHistory() throws {
        let item = ContentItem.show(id: 1)
        let resource = trakt.resources.sync.removeFromHistory([item])
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/sync/history/remove")
        XCTAssertEqual(resource.request.httpMethod, "POST")
    }
}
