//
//  ListResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class ListResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testSummary() {
        let resource = trakt.resources.user("mrmojo").list(name: "couchy-added").summary
        let data = buildJsonData(name: "list-summary")
        let list = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists/couchy-added")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(list.name, "couchy-added")
    }

    func testItems() {
        let resource = trakt.resources.user("mrmojo").list(name: "couchy-added").items(type: .shows, extended: .full)
        let data = buildJsonData(name: "list-items")
        let items = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists/couchy-added/shows?extended=full")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(items.count, 49)
    }

    func testAddItems() {
        let show = ContentItem.show(id: 107717)
        let seasons = ContentItem.season(numbers: [1], show: 107717)
        let episodes = ContentItem.episodes(numbers: [1, 2, 3, 4, 5], season: 2, show: 107717)
        let items = [show, seasons, episodes]
        let resource = trakt.resources.user("mrmojo").list(name: "couchy-added").add(items: items)
        let data = buildJsonData(name: "list-items-add")
        _ = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists/couchy-added/items")
        XCTAssertEqual(resource.request.httpMethod, "POST")
    }

    func testRemoveItems() {
        let show = ContentItem.show(id: 107717)
        let seasons = ContentItem.season(numbers: [1], show: 107717)
        let episodes = ContentItem.episodes(numbers: [1, 2, 3, 4, 5], season: 2, show: 107717)
        let items = [show, seasons, episodes]
        let resource = trakt.resources.user("mrmojo").list(name: "couchy-added").remove(items: items)
        let data = buildJsonData(name: "list-items-add")
        _ = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists/couchy-added/items/remove")
        XCTAssertEqual(resource.request.httpMethod, "POST")
    }
}
