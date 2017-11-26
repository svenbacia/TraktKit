//
//  TraktSeasonTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 26.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class TraktSeasonTests: XCTestCase {

    func testSeasons() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects seasons for show")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-seasons")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(112663).seasons(.full), authenticated: false) { (result) in
            if result.value?.0.count == 2 {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/112663/seasons?extended=full"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testSeasonsWithEpisodes() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects seasons with episode information for show")
        
        let session = FakeURLSession.success(statusCode: 200, json: "show-seasons-episodes")
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        
        let task = trakt.load(resource: trakt.show(112663).seasons([.episodes]), authenticated: false) { (result) in
            if result.value?.0.count == 2 {
                expectation.fulfill()
            } else if let error = result.error {
                XCTFail(error.localizedDescription)
            }
        }
        XCTAssertNotNil(task)
        
        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/112663/seasons?extended=episodes"))
        XCTAssertEqual(request.httpMethod, "GET")
        
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
}
