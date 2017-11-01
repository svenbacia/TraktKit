//
//  ListRequestTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ListRequestTests: XCTestCase {
    
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
    
    // MARK: - List Tests
    
    func testListSummary() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects list summary")
//
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//
//        let task = trakt.load(resource: trakt.user(with: "user").list(with: "list-name").summary(), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists/list-name"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testListItems() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects list items")
//
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//
//        let task = trakt.load(resource: trakt.user(with: "user").list(with: "list-name").items(ofType: .show), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists/list-name/items/show"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testListAddItem() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects adding item to list")
//
//        let items = [ContentType.show(id: 1, title: "show")]
//
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//
//        let task = trakt.load(resource: trakt.user(with: "user").list(with: "list-name").add(items: items), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists/list-name/items"))
//        XCTAssertEqual(request.httpMethod, "POST")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testListRemoveItem() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects removing item from list")
//        
//        let items = [ContentType.show(id: 1, title: "show")]
//        
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//        
//        let task = trakt.load(resource: trakt.user(with: "user").list(with: "list-name").remove(items: items), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//        
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists/list-name/items/remove"))
//        XCTAssertEqual(request.httpMethod, "POST")
//        
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
}
