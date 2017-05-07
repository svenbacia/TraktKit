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
            if let error = result.error {
                switch error {
                case .unknownServerResponse:
                    expectation.fulfill()
                default: break
                }
            }
        }
        
        XCTAssertNotNil(task)
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testUnknownStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 987, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects unkown status code")
        
        let task = trakt.trendingShows { (result) in
            if let error = result.error {
                switch error {
                case .unknownStatusCode(let statusCode, _, _):
                    if statusCode == 987 {
                        expectation.fulfill()
                    }
                default: break
                }
            }
        }
        
        XCTAssertNotNil(task)
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testBadStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        
        let trakt = Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: session, isDebug: true)
        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 60))
        
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects bad status code")
        
        let items = [ContentType.episode(id: 123, date: nil)]
        let task = trakt.addToHistory(items: items) { (result) in
            if let error = result.error {
                switch error {
                case .badStatusCode(let statusCode, _, _):
                    if statusCode.rawValue == 404 {
                        expectation.fulfill()
                    }
                default: break
                }
            }
        }
        
        XCTAssertNotNil(task)
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
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
            if let error = result.error {
                switch error {
                case .invalidResponseData:
                    expectation.fulfill()
                default: break
                }
            }
        }
        
        XCTAssertNotNil(task)
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
