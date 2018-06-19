//
//  SearchResourceTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class SearchResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testProfile() throws {
        let resource = trakt.resources.search.for("Lethal Weapon", ofType: .show)
        let data = buildJsonData(name: "search-show")
        let items = try resource.parse(data)
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/search/show?query=Lethal%20Weapon")
        XCTAssertEqual(resource.request.httpMethod, "GET")
        XCTAssertEqual(items.first!.type, .show)
        XCTAssertEqual(items.first!.score, 1267.0225, accuracy: Double.ulpOfOne)
        XCTAssertEqual(items.first!.show!.title, "Lethal Weapon")
    }
}
