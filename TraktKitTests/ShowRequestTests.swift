//
//  ShowRequestTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ShowRequestTests: XCTestCase {
    
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
    
    // MARK: - Show Tests
    
    func testShowSummary() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show summary")
//
//        let task = trakt.load(resource: trakt.show(with: 1).summary(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowComments() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show comments")
//
//        let task = trakt.load(resource: trakt.show(with: 1).comments(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/comments"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowPeople() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show people")
//
//        let task = trakt.load(resource: trakt.show(with: 1).people(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/people"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowRatings() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show ratings")
//
//        let task = trakt.load(resource: trakt.show(with: 1).ratings(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/rating"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testRelatedShowsForShow() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects related shows")
//
//        let task = trakt.load(resource: trakt.show(with: 1).related(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/related"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowStats() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show stats")
//
//        let task = trakt.load(resource: trakt.show(with: 1).stats(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/stats"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowWatching() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects users watching this show")
//
//        let task = trakt.load(resource: trakt.show(with: 1).watching(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/watching"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowCollectionProgress() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show collection progress")
//
//        let task = trakt.load(resource: trakt.show(with: 1).collectionProgress(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/progress/collection"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowWatchedProgress() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show watched progress")
//
//        let task = trakt.load(resource: trakt.show(with: 1).watchedProgress(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/progress/watched"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testShowAllSeasons() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects show collection progress")
//        
//        let task = trakt.load(resource: trakt.show(with: 1).seasons(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//        
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1/seasons"))
//        XCTAssertEqual(request.httpMethod, "GET")
//        
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
}
