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
        
    func testTrendingShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects trending shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-trending")
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        let task = trakt.load(resource: trakt.explore.shows.trending(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/trending"))
        XCTAssertEqual(request.httpMethod, "GET")

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testPopularShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects popular shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-popular")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.explore.shows.popular(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/popular"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testAnticipatedShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects anticipated shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-anticipated")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.explore.shows.anticipated(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/anticipated"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testPlayedShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects played shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-played")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.explore.shows.played(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/played"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testWatchedShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects watched shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-watched")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.explore.shows.watched(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/watched"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testCollectedShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects most collected shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "shows-collected")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.explore.shows.collected(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/collected"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
