//
//  PeopleRequestTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class PeopleRequestTests: XCTestCase {
    
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
    
    func testPeopleSummary() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects people summary")
        
        let task = trakt.load(resource: trakt.person(123).summary(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/people/123"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testPeopleShows() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects people shows")
        
        let task = trakt.load(resource: trakt.person(123).shows(), authenticated: false) { result in
            if result.value != nil {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/people/123/shows"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
