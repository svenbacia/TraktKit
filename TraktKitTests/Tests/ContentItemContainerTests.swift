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
        let seasonsItem = ContentItem.season(numbers: [1, 2], show: 345)
        let episodesItem = ContentItem.episodes(numbers: [1, 2, 3], season: 5, show: 987)
        let episodeItems = [
            ContentItem.episode(id: 1),
            ContentItem.episode(id: 2),
            ContentItem.episode(id: 3)
        ]
        let personItem = ContentItem.person(name: "Name", id: 159)

        let items = [
            movieItem,
            showItem,
            seasonsItem,
            episodesItem,
            personItem
        ] + episodeItems

        let container = ContentItemContainer(items: items)

        let json = container.asJSON

        XCTAssertEqual((json["movies"] as! [Any]).count, 1)
        XCTAssertEqual((json["shows"] as! [Any]).count, 3)
        XCTAssertEqual((json["people"] as! [Any]).count, 1)
        XCTAssertEqual((json["episodes"] as! [Any]).count, 3)
    }

    func testEmptyJSON() {
        let container = ContentItemContainer(items: [])
        let json = container.asJSON
        XCTAssertEqual((json["movies"] as! [Any]).count, 0)
        XCTAssertEqual((json["shows"] as! [Any]).count, 0)
        XCTAssertEqual((json["people"] as! [Any]).count, 0)
        XCTAssertEqual((json["episodes"] as! [Any]).count, 0)
    }
}
