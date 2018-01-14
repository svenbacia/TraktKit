//
//  SearchTypeTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class SearchTypeTests: XCTestCase {

    func testEquality() {
        XCTAssertEqual(SearchType.show, SearchType.show)
        XCTAssertEqual(SearchType.episode, SearchType.episode)
        XCTAssertEqual(SearchType.list, SearchType.list)
        XCTAssertEqual(SearchType.person, SearchType.person)
        XCTAssertEqual(SearchType.movie, SearchType.movie)
        XCTAssertNotEqual(SearchType.show, SearchType.movie)
    }
}
