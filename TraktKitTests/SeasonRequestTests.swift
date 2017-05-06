//
//  SeasonRequestTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class SeasonRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    let session = FakeURLSession { request in
        let data = buildData(with: [])
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response, nil)
    }
    
    lazy var trakt: Trakt = {
        Trakt(credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"), session: self.session)
    }()
    
    // MARK: -
    
    override func setUp() {
        super.setUp()
        session.reset()
    }
    
    // MARK: -
    
    func testSeasonSummary() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects season summary")
        
        let task = trakt.load(resource: trakt.show(with: 123).season(1).summary(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/123/seasons/1"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testSeasonComments() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects season comments")
        
        let task = trakt.load(resource: trakt.show(with: 123).season(1).comments(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/123/seasons/1/comments"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testSeasonRatings() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects season ratings")
        
        let task = trakt.load(resource: trakt.show(with: 123).season(1).ratings(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/123/seasons/1/ratings"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testSeasonStats() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects season stats")
        
        let task = trakt.load(resource: trakt.show(with: 123).season(1).stats(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/123/seasons/1/stats"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testSeasonWatching() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects season watching")
        
        let task = trakt.load(resource: trakt.show(with: 123).season(1).watching(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/123/seasons/1/watching"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
