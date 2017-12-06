//
//  PeopleResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class PeopleResourceTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()
    
    // MARK: - Tests
    
    func testSummary() {
        let resource = trakt.resources.people(424273).summary()
        let data = buildJsonData(name: "people-summary")
        let person = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/people/\(424273)")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(person.ids.trakt, 424273)
    }
    
    func testShows() {
        let resource = trakt.resources.people(424273).shows()
        let data = buildJsonData(name: "people-shows")
        let shows = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/people/\(424273)/shows")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(shows.cast.count, 3)
    }
}
