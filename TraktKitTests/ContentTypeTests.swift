//
//  ContentTypeTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ContentTypeTests: XCTestCase {
  
  func testDescription() {
    XCTAssertEqual(ContentType.show(id: 0, title: "").description, "Show")
    XCTAssertEqual(ContentType.season(0).description, "Season")
    XCTAssertEqual(ContentType.episode(id: 0, date: nil).description, "Episode")
    XCTAssertEqual(ContentType.movie(id: 0, title: "", year: "").description, "Movie")
  }
  
  func testParametersForShow() {
    let item = ContentType.show(id: 1, title: "Test Show")
    let params = parameters(with: [item])
    let shows = params["shows"] as? [Any]
    let episodes = params["episodes"] as? [Any]
    XCTAssertEqual(shows?.count, 1)
    XCTAssertEqual(episodes?.count, 0)
  }
  
  func testParametersForEpisode() {
    let item = ContentType.episode(id: 1, date: "date")
    let params = parameters(with: [item])
    let shows = params["shows"] as? [Any]
    let episodes = params["episodes"] as? [Any]
    XCTAssertEqual(shows?.count, 0)
    XCTAssertEqual(episodes?.count, 1)
  }
  
}
