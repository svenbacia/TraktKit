//
//  TraktShowTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class TraktShowTests: XCTestCase {
    
    func testShowSummary() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects show summary")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-summary")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).summary(), authenticated: false) { (result) in
            if result.value?.0.ids.trakt == 107717 {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowComments() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects show comments")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-comments")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).comments(), authenticated: false) { (result) in
            if result.value?.0.count == 10 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/comments"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowPeople() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects show people")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-people")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).people(), authenticated: false) { (result) in
            if result.value!.0.cast.count == 9 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/people"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowRating() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects show rating")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-rating")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).rating(), authenticated: false) { (result) in
            if result.value!.0.votes == 1184 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/rating"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowRelated() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects related shows")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-related")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).related(), authenticated: false) { (result) in
            if result.value!.0.count == 10 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/related"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowStats() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects show stats")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-stats")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).stats(), authenticated: false) { (result) in
            if result.value!.0.watchers == 58359 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/stats"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testShowWatching() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects watching users for show")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-watching")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(107717).watching(), authenticated: false) { (result) in
            if result.value!.0.count == 10 {
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/107717/watching"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
