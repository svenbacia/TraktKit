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

    let session = FakeURLSession { request in
        let data = buildData(with: [])
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response, nil)
    }

    lazy var trakt: Trakt = {
        let configuration = Trakt.Configuration(isDebug: true)
        let trakt = Trakt(session: self.session, credentials: Helper.credentials, configuration: configuration, keychain: Keychain.default)
        trakt.token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: .distantFuture)
        return trakt
    }()

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        session.reset()
    }

    // MARK: - Tests

    func testTraktHTTPHeader() {
        let task = trakt.load(resource: trakt.resources.show(1).summary(), authenticated: true) { _ in }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
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
        XCTAssertNil(session.completedRequests.first)
        XCTAssertNil(session.requests.first)

        let waiter = XCTWaiter()
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
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
        XCTAssertNil(session.completedRequests.first)
        XCTAssertNil(session.requests.first)

        let waiter = XCTWaiter()
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testUnknownServerResponse() {
        let session = FakeURLSession { _ in return (nil, nil, nil) }
        let trakt = Trakt(session: session,
                          credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"),
                          keychain: .default)

        let expectation = self.expectation(description: "expects unkown server response")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.unknownServerResponse("", nil) {
                expectation.fulfill()
            } else {
                XCTFail("expected unknown server response error")
            }
        }
        XCTAssertNotNil(task)

        let waiter = XCTWaiter()
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testUnknownStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 987, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(session: session,
                          credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"),
                          keychain: .default)

        let expectation = self.expectation(description: "expects unkown status code")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.unknownHttpStatusCode("", HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 987, httpVersion: nil, headerFields: nil)!, nil) {
                expectation.fulfill()
            } else {
                XCTFail("expected unknown http status code error")
            }
        }
        XCTAssertNotNil(task)

        let waiter = XCTWaiter()
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testBadStatsCode() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(session: session,
                          credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"),
                          keychain: .default)
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

    func testInvalidResponseData() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        }
        let trakt = Trakt(session: session,
                          credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"),
                          keychain: .default)

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects invalid response data")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.missingResponseData("", HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil) {
                expectation.fulfill()
            } else {
                XCTFail("expected missing response data error")
            }
        }
        XCTAssertNotNil(task)

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testJsonDecodingError() {
        let session = FakeURLSession { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = buildJsonData(name: "shows-watched")!
            return (data, response, nil)
        }
        let trakt = Trakt(session: session,
                          credentials: Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI"),
                          keychain: .default)

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects invalid response data")

        let task = trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in
            if let error = result.error, error == Trakt.Error.jsonDecodingError("", JSONError.invalidDateFormat("")) {
                expectation.fulfill()
            } else {
                XCTFail("expected json decoding error")
            }
        }
        XCTAssertNotNil(task)

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
