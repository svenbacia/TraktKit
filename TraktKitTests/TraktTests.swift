//
//  TraktTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class TraktTests: XCTestCase {
    
    // MARK: - Properties
    
    let session = FakeURLSession { request in
        let data = buildData(with: [])
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response, nil)
    }
    
    lazy var trakt: Trakt = {
        Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: self.session, isDebug: true)
    }()
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        session.reset()
    }
    
    // MARK: - Tests
    
    func testTraktHTTPHeader() {
        let task = trakt.load(resource: trakt.show(with: 1).summary(), authenticated: false) { _ in }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let header = request.allHTTPHeaderFields!
        XCTAssertEqual(header["trakt-api-key"], "clientID")
        XCTAssertEqual(header["trakt-api-version"], "2")
        XCTAssertEqual(header["Content-Type"], "application/json")
    }
    
    func testAuthenticatedRequestShouldFailWhenTokenIsMissing() {
        trakt.invalidateToken()
        let task = trakt.load(resource: trakt.show(with: 1).summary(), authenticated: true) { _ in }
        XCTAssertNil(task)
        XCTAssertNil(session.completedRequests.first)
        XCTAssertNil(session.requests.first)
    }
    
    func testUnknownServerResponse() {
        let session = FakeURLSession { _ in
            return (nil, nil, nil)
        }
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects unkown server response")
        
        let task = trakt.trendingShows { (result) in
            if result.error != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        waiter.wait(for: [expectation], timeout: 1)
    }
    
    func testUnknownStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 123456789, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects unkown server response")
        
        let task = trakt.trendingShows { (result) in
            if result.error != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        waiter.wait(for: [expectation], timeout: 1)
    }
    
    func testBadStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects unkown server response")
        
        let task = trakt.trendingShows { (result) in
            if result.error != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        waiter.wait(for: [expectation], timeout: 1)
    }
    
    func testInvalidResponseData() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects unkown server response")
        
        let task = trakt.trendingShows { (result) in
            if result.error != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        waiter.wait(for: [expectation], timeout: 1)
    }
}
