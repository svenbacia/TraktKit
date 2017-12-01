//
//  TraktSyncTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class TraktSyncTests: XCTestCase {
    
    // MARK: - Properties
    
    let session = FakeURLSession { request in
        let data = buildData(with: [])
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response, nil)
    }
    
    lazy var trakt: Trakt = {
        Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: self.session)
    }()
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        session.reset()
    }
    
    // MARK: - Sync Tests
    
    func testLastActivities() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects last activities")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let task = trakt.lastActivities { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/last_activities"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testCollection() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects collection")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let task = trakt.collection { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/collection/shows"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testWatched() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects watched shows")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let task = trakt.watched { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/watched/shows"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testWatchlist() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects watchlist")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let task = trakt.watchlist { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/watchlist/shows"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    // MARK: - History
    
    func testAddToHistory() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects adding item to history")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let items = [ContentType.episode(id: 1, date: nil)]
        let task = trakt.addToHistory(items: items) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/history"))
        XCTAssertEqual(request.httpMethod, "POST")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testRemoveFromHistory() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects removing item from history")
        
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
        
        let items = [ContentType.episode(id: 1, date: nil)]
        let task = trakt.removeFromHistory(items: items) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/sync/history/remove"))
        XCTAssertEqual(request.httpMethod, "POST")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
