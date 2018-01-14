//
//  ProgressTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class ProgressResourceTests: XCTestCase {

    // MARK: - Properties

    private lazy var trakt: Trakt = {
        return Trakt(credentials: Helper.credentials)
    }()

    // MARK: - Tests

    func testCollectionProgress() {
        let resource = trakt.resources.show(107717).progress.collection()
        let data = buildJsonData(name: "show-collection-progress")
        let progress = try! resource.parse(data!)
        XCTAssertEqual(progress.aired, 26)
        XCTAssertEqual(progress.completed, 0)
        XCTAssertEqual(progress.hiddenSeasons.count, 0)
        XCTAssertEqual(progress.seasons.count, 2)
        XCTAssertNil(progress.lastCollectedAt)
        XCTAssertNil(progress.lastEpisode)
        XCTAssertEqual(progress.nextEpisode!.title, "Pilot")
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/progress/collection")
    }

    func testWatchedProgress() {
        let resource = trakt.resources.show(107717).progress.watched()
        let data = buildJsonData(name: "show-watched-progress")
        let progress = try! resource.parse(data!)
        XCTAssertEqual(progress.aired, 26)
        XCTAssertEqual(progress.completed, 26)
        XCTAssertEqual(progress.hiddenSeasons.count, 0)
        XCTAssertEqual(progress.seasons.count, 2)
        XCTAssertNotNil(progress.lastWatchedAt)
        XCTAssertEqual(progress.lastEpisode!.title, "Fork-Getta-Bout-It")
        XCTAssertEqual(progress.nextEpisode!.title, "Fools Rush In")
        XCTAssertEqual(resource.request.url?.absoluteString, "https://api.trakt.tv/shows/107717/progress/watched")
    }
}
