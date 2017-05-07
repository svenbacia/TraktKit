//
//  TraktErrorTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class TraktErrorTests: XCTestCase {

    func testDescriptionAvailable() {
        XCTAssertTrue(TraktError.badStatusCode(.badRequest, nil).description.characters.count > 0)
        XCTAssertTrue(TraktError.invalidAuthorization.description.characters.count > 0)
        XCTAssertTrue(TraktError.invalidResponseData(nil).description.characters.count > 0)
        XCTAssertTrue(TraktError.invalidResponseJson(buildError(reason: "test")).description.characters.count > 0)
        XCTAssertTrue(TraktError.unknownServerResponse(nil).description.characters.count > 0)
        XCTAssertTrue(TraktError.unknownStatusCode(123456789, buildError(reason: "test")).description.characters.count > 0)
    }
}

