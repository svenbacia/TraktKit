//
//  TraktAuthTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest
@testable import TraktKit

class AuthTests: XCTestCase {

    // MARK: -

    func testTokenIsAuthorized_true() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "123", expiry: .distantFuture)
        XCTAssertTrue(trakt.isAuthorized)
    }

    func testTokenIsAuthorized_missingToken() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        trakt.token = nil
        XCTAssertFalse(trakt.isAuthorized)
    }

    func testTokenIsExpired() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "123", expiry: .distantPast)
        XCTAssertTrue(trakt.isExpired)
    }

    func testTokenIsExpired_missingToken() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        trakt.token = nil
        XCTAssertTrue(trakt.isExpired)
    }

    func testAuthorizationUrl() {
        let session = FakeURLSession.failure(statusCode: 500)
        let credentials = Credentials(clientID: "id", clientSecret: "secret", redirectURI: "uri")
        let trakt = Trakt(session: session, credentials: credentials)
        let url = URL(string: "https://www.trakt.tv/oauth/authorize?redirect_uri=uri&response_type=code&client_id=id")!
        XCTAssertEqual(trakt.authorizationURL, url)
    }

    func testLoadToken() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        let token = Token(accessToken: "access", refreshToken: "refresh", expiry: .distantFuture)
        trakt.token = token

        let anotherTrakt = Trakt(session: session, credentials: Helper.credentials)

        XCTAssertEqual(anotherTrakt.token, token)
    }

    func testTokenMigration() throws {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)
        trakt.token = nil

        // simulate old token, pre v1.0
        try Keychain(service: "com.svenbacia.traktkit.trakt.accessToken").setPassword("old-access-token")
        try Keychain(service: "com.svenbacia.traktkit.trakt.refreshToken").setPassword("old-refresh-token")
        UserDefaults.standard.set(Date.distantFuture, forKey: "trakt.expiry")

        let token = trakt.migrateToken()
        XCTAssertNotNil(token)
        XCTAssertEqual(token!.accessToken, "old-access-token")
        XCTAssertEqual(token!.refreshToken, "old-refresh-token")
    }

    // MARK: Access Token

    func testExchangeAccessTokenForCode_success() {
        let session = FakeURLSession.success(statusCode: 200, json: "get-token")
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

        let waiter = XCTWaiter()
        let tokenExpectation = expectation(description: "expects auth token")

        // exchange code for token
        let task = trakt.exchangeAccessToken(for: "some-oauth-code") { (result) in
            if let token = result.value,
                token.accessToken == "dbaf9757982a9e738f05d249b7b5b4a266b3a139049317c4909f2f263572c781",
                token.refreshToken == "76ba4c5c75c96f6087f58a4de10be6c00b29ea1ddc3b2022ee2016d1363e3a7c",
                token.expiry > Date(),
                trakt.isAuthorized {
                tokenExpectation.fulfill()
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        let result = waiter.wait(for: [tokenExpectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testExchangeAccessTokenForCode_failure() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

        let waiter = XCTWaiter()
        let tokenExpectation = expectation(description: "expects server error")

        // exchange code for token
        let task = trakt.exchangeAccessToken(for: "some-oauth-code") { (result) in
            if result.error != nil {
                tokenExpectation.fulfill()
            } else {
                XCTFail("expected error due to server error")
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        let result = waiter.wait(for: [tokenExpectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    // MARK: Refresh Token

    func testExchangeRefreshForAccessToken_success() {
        let session = FakeURLSession.success(statusCode: 200, json: "exchange-refresh-for-access-token")
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = Token(accessToken: "access-token", refreshToken: "refresh-token", expiry: .distantFuture)

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects refresh token")

        // exchange code for token
        let task = trakt.exchangeRefreshToken { (result) in
            if let token = result.value,
                token.accessToken == "dbaf9757982a9e738f05d249b7b5b4a266b3a139049317c4909f2f263572c781",
                token.refreshToken == "76ba4c5c75c96f6087f58a4de10be6c00b29ea1ddc3b2022ee2016d1363e3a7c" {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testExchangeRefreshForAccessToken_missingRefreshToken() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects server error")

        // exchange code for token
        let task = trakt.exchangeRefreshToken { (result) in
            if result.error != nil {
                expectation.fulfill()
            } else {
                XCTFail("expected error due to missing refresh token")
            }
        }
        XCTAssertNil(task)
        XCTAssertNil(session.completedRequests.first)

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testExchangeRefreshForAccessToken_serverError() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = Token(accessToken: "access-token", refreshToken: "refresh-token", expiry: .distantFuture)

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects server error")

        // exchange code for token
        let task = trakt.exchangeRefreshToken { (result) in
            if result.error != nil {
                expectation.fulfill()
            } else {
                XCTFail("expected error due to server error")
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    // MARK: - Revoke Access Token

    func testRevokeAccessToken_success() {
        let session = FakeURLSession.success(statusCode: 200, json: "empty")
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // add valid token
        trakt.token = Token(accessToken: "123", refreshToken: "312", expiry: Date.distantFuture)

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects status code 200")

        let task = trakt.revokeAccessToken { (result) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("expected successful response from server")
            }
        }
        XCTAssertNotNil(task)

        let request = session.completedRequests.first!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/revoke"))
        XCTAssertEqual(request.httpMethod, "POST")

        let contentType = request.allHTTPHeaderFields?["Content-Type"]
        XCTAssertEqual(contentType!, "application/x-www-form-urlencoded")

        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertEqual(body, "token=123")

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testRevokeAccessToken_missingAuthorization() {
        let session = FakeURLSession.success(statusCode: 200, json: "empty")
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate token
        trakt.token = nil

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects missing authorization")

        let task = trakt.revokeAccessToken { (result) in
            switch result {
            case .success:
                break
            case .failure:
                expectation.fulfill()
            }
        }
        XCTAssertNil(task)

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }

    func testRevokeAccessToken_serverError() {
        let session = FakeURLSession.failure(statusCode: 500)
        let trakt = Trakt(session: session, credentials: Helper.credentials)

        // invalidate token
        trakt.token = nil

        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects server error")

        let task = trakt.revokeAccessToken { (result) in
            switch result {
            case .success:
                break
            case .failure:
                expectation.fulfill()
            }
        }
        XCTAssertNil(task)

        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}
