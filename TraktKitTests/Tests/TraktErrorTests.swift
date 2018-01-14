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
        XCTAssertFalse(Trakt.Error.badHttpStatusCode(.badRequest, nil).description.isEmpty)
        XCTAssertFalse(Trakt.Error.invalidAuthorization.description.isEmpty)
        XCTAssertFalse(Trakt.Error.jsonDecodingError(JSONError.invalidDateFormat("")).description.isEmpty)
        XCTAssertFalse(Trakt.Error.missingAuthorization.description.isEmpty)
        XCTAssertFalse(Trakt.Error.missingResponseData(HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 0, httpVersion: nil, headerFields: nil)!, nil).description.isEmpty)
        XCTAssertFalse(Trakt.Error.unknownHttpStatusCode(HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 0, httpVersion: nil, headerFields: nil)!, nil).description.isEmpty)
        XCTAssertFalse(Trakt.Error.unknownServerResponse(nil).description.isEmpty)
    }

    func testDebugDescriptionAvailable() {
        XCTAssertFalse(Trakt.Error.badHttpStatusCode(.badRequest, nil).debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.invalidAuthorization.debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.jsonDecodingError(JSONError.invalidDateFormat("")).debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.missingAuthorization.debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.missingResponseData(HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 0, httpVersion: nil, headerFields: nil)!, nil).debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.unknownHttpStatusCode(HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 0, httpVersion: nil, headerFields: nil)!, nil).debugDescription.isEmpty)
        XCTAssertFalse(Trakt.Error.unknownServerResponse(nil).debugDescription.isEmpty)
    }
}

