//
//  UserResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class UserResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testProfile() {
        let resource = trakt.resources.user("mrmojo").profile()
        let data = buildJsonData(name: "user-profile")
        let user = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(user.username, "mrmojo")
    }

    func testStats() {
        let resource = trakt.resources.user("username").stats
        let data = buildJsonData(name: "user-stats")
        let stats = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/username/stats")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(stats.episodes.watched, 1000)
    }

    func testLists() {
        let resource = trakt.resources.user("mrmojo").lists
        let data = buildJsonData(name: "user-lists")
        let lists = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(lists.count, 7)
    }

    func testCreateList() {
        let resource = trakt.resources.user("mrmojo").createList(name: "test-list2", description: "description", privacy: .private, displayNumbers: false, allowComments: true)
        let data = buildJsonData(name: "user-create-list")
        let list = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/users/mrmojo/lists")
        XCTAssertEqual(resource.request.httpMethod, "POST")
        XCTAssertEqual(list.name, "test-list2")
    }
}
