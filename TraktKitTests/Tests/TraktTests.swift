//
//  TraktTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
@testable import TraktKit

class TraktTests: XCTestCase {

    // MARK: - Properties

    lazy var trakt: Trakt = {
        let configuration = Trakt.Configuration(isDebug: true)
        let trakt = Trakt(session: Helper.mockURLSession(json: "empty"), credentials: Helper.credentials, configuration: configuration, keychain: Keychain.default)
        trakt.token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: .distantFuture)
        return trakt
    }()

    // MARK: - Tests

    func testTraktHTTPHeader() {
        let task = trakt.load(resource: trakt.resources.show(1).summary(), authenticated: true) { _ in }
        XCTAssertNotNil(task)

        let request = task!.originalRequest!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/shows/1"))
        XCTAssertEqual(request.httpMethod, "GET")

        let header = request.allHTTPHeaderFields!
        XCTAssertEqual(header["trakt-api-key"], "clientID")
        XCTAssertEqual(header["trakt-api-version"], "2")
        XCTAssertEqual(header["Content-Type"], "application/json")
    }

    func testAuthenticatedRequestShouldFailWhenTokenIsMissing() {
        let expectation = self.expectation(description: "missing authorization error expected")

        trakt.token = nil
        let task = trakt.load(resource: trakt.resources.show(1).summary(), authenticated: true) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                if error == Trakt.Error.missingAuthorization("") {
                    expectation.fulfill()
                }
            }
        }
        XCTAssertNil(task)
        wait(for: [expectation], timeout: 1)
    }

    func testAuthenticatedRequestShouldFailWhenTokenIsExpired() {
        let expectation = self.expectation(description: "missing authorization error expected")

        trakt.token = Token(accessToken: "123", refreshToken: "321", expiry: .distantPast)
        let task = trakt.load(resource: trakt.resources.show(1).summary(), authenticated: true) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                if error == Trakt.Error.invalidAuthorization("") {
                    expectation.fulfill()
                }
            }
        }
        XCTAssertNil(task)

        wait(for: [expectation], timeout: 1)
    }

    func testUnknownStatsCode() {
        let trakt = Trakt(session: Helper.mockURLSession(statusCode: 999, json: "empty"), credentials: Helper.credentials)
        let expectation = self.expectation(description: "expects unkown status code")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.unknownHttpStatusCode("", Helper.httpUrlResponse, nil) {
                expectation.fulfill()
            } else {
                XCTFail("expected unknown http status code error")
            }
        }
        XCTAssertNotNil(task)

        wait(for: [expectation], timeout: 1)
    }

    func testBadStatsCode() {
        let trakt = Trakt(session: Helper.mockURLSession(statusCode: 404, json: "empty"),
                          credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "321", expiry: .distantFuture)

        let expectation = self.expectation(description: "expects bad status code")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.badHttpStatusCode("", .notFound, nil) {
                expectation.fulfill()
            } else {
                XCTFail("expected bad http status code error")
            }
        }
        XCTAssertNotNil(task)

        let waiter = XCTWaiter()
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testJsonDecodingError() {
        let trakt = Trakt(session: Helper.mockURLSession(json: "user-lists"),
                          credentials: Helper.credentials)

        let expectation = self.expectation(description: "expects invalid response data")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.jsonDecodingError("", JSONError.invalidDateFormat("")) {
                expectation.fulfill()
            } else {
                XCTFail("expected json decoding error")
            }
        }
        XCTAssertNotNil(task)

        wait(for: [expectation], timeout: 1)
    }
}
