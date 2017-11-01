//
//  TraktExploreTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class TraktExploreTests: XCTestCase {
    
    // MARK: - Properties
    
    let session = FakeURLSession { request in
        let data = buildData(with: [])
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response, nil)
    }
    
    lazy var trakt: Trakt = {
        Trakt(session: self.session, credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), keychain: Keychain.default)
    }()
    
    // MARK: -
    
    override func setUp() {
        super.setUp()
        session.reset()
    }
    
    // MARK: -
    
    func testTrendingShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects trending shows")
//
//        let task = trakt.trendingShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/trending"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testPopularShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects popular shows")
//
//        let task = trakt.popularShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/popular"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testAnticipatedShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects anticipated shows")
//
//        let task = trakt.anticipatedShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/anticipated"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testPlayedShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects played shows")
//
//        let task = trakt.playedShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/played"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testWatchedShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects watched shows")
//
//        let task = trakt.watchedShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/watched"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testCollectedShows() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects collected shows")
//
//        let task = trakt.collectedShows { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/collected"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
}
