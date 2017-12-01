//
//  SeasonResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class SeasonResourceTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()
    
    // MARK: - Tests
    
    func testSeasons() {
        let resource = trakt.resources.show(112663).seasons(.full)
        let data = buildJsonData(name: "show-seasons")
        let seasons = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/112663/seasons?extended=full")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(seasons.count, 2)
    }
    
    func testSeasonsWithEpisodes() {
        let resource = trakt.resources.show(112663).seasons(.episodes)
        let data = buildJsonData(name: "show-seasons-episodes")
        let seasons = try! resource.parse(data!)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/112663/seasons?extended=episodes")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(seasons.count, 2)
        XCTAssertEqual(seasons.first!.episodes!.count, 18)
        XCTAssertEqual(seasons.last!.episodes!.count, 9)
    }
}
