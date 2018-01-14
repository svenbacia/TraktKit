//
//  ContentItemContainerTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 02.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
@testable import TraktKit

class ContentItemContainerTests: XCTestCase {

    func testJSON() {
        let movieItem = ContentItem.movie(id: 123)
        let showItem = ContentItem.show(id: 234)
        let seasonsItem = ContentItem.season(numbers: [1, 2], id: 345)
        let episodesItem = ContentItem.episode(numbers: [1, 2, 3], season: 5, show: 987)
        let personItem = ContentItem.person(name: "Name", id: 159)

        let container = ContentItemContainer(items: [
            movieItem,
            showItem,
            seasonsItem,
            episodesItem,
            personItem
            ])

        let json = container.asJSON

        XCTAssertEqual((json["movies"] as! [Any]).count, 1)
        XCTAssertEqual((json["shows"] as! [Any]).count, 3)
        XCTAssertEqual((json["people"] as! [Any]).count, 1)
    }

    func testEmptyJSON() {
        let container = ContentItemContainer(items: [])
        let json = container.asJSON
        XCTAssertEqual((json["movies"] as! [Any]).count, 0)
        XCTAssertEqual((json["shows"] as! [Any]).count, 0)
        XCTAssertEqual((json["people"] as! [Any]).count, 0)
    }
}
