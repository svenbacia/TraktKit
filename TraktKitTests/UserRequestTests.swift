//
//  UserRequestTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class UserRequestTests: XCTestCase {
    
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
    
    // MARK: - User Tests
    
    func testUserProfile() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects user profile")
//
//        let task = trakt.load(resource: trakt.user(with: "user").profile(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testUserStats() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects user stats")
//
//        let task = trakt.load(resource: trakt.user(with: "user").stats(), authenticated: false) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/stats"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testUserLists() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects user lists")
//
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//
//        let task = trakt.load(resource: trakt.user(with: "user").lists(), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists"))
//        XCTAssertEqual(request.httpMethod, "GET")
//
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
    func testUserCreateList() {
//        let waiter = XCTWaiter()
//        let expectation = self.expectation(description: "expects create list")
//        
//        trakt.update(accessToken: "access", refreshToken: "refresh", expiry: Date(timeIntervalSinceNow: 3600))
//        
//        let task = trakt.load(resource: trakt.user(with: "user").createList(with: "list-name", description: "my list", privacy: .private, displayNumbers: false, allowComments: false), authenticated: true) { result in
//            if result.value != nil {
//                expectation.fulfill()
//            }
//        }
//        XCTAssertNotNil(task)
//        
//        let request = session.completedRequests.first!
//        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/users/user/lists"))
//        XCTAssertEqual(request.httpMethod, "POST")
//        
//        let result = waiter.wait(for: [expectation], timeout: 1)
//        XCTAssertEqual(result, .completed)
    }
    
}
