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

    func testTokenIsAuthorized() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "123", expiry: .distantFuture)
        XCTAssertTrue(trakt.isAuthorized)
    }

    func testTokenIsAuthorized_missingToken() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        trakt.token = nil
        XCTAssertFalse(trakt.isAuthorized)
    }

    func testTokenIsExpired() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "123", expiry: .distantPast)
        XCTAssertTrue(trakt.isExpired)
    }

    func testTokenIsExpired_missingToken() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        trakt.token = nil
        XCTAssertTrue(trakt.isExpired)
    }

    func testAuthorizationUrl() {
        let credentials = Credentials(clientID: "id", clientSecret: "secret", redirectURI: "uri")
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: credentials)

        let components = URLComponents(url: trakt.authorizationURL, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "www.trakt.tv")
        XCTAssertEqual(components.path, "/oauth/authorize")

        let queryItems = components.queryItems!
        XCTAssertEqual(queryItems.first(where: { $0.name == "redirect_uri" })!.value!, "uri")
        XCTAssertEqual(queryItems.first(where: { $0.name == "response_type" })!.value!, "code")
        XCTAssertEqual(queryItems.first(where: { $0.name == "client_id" })!.value!, "id")
    }

    func testLoadToken() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        let token = Token(accessToken: "access", refreshToken: "refresh", expiry: .distantFuture)
        trakt.token = token

        let anotherTrakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        XCTAssertEqual(anotherTrakt.token, token)
    }

    func testTokenMigration() throws {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
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
        let trakt = Trakt(session: Helper.mockURLSession(json: "get-token"), credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

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

        let request = task!.originalRequest!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        wait(for: [tokenExpectation], timeout: 1)
    }

    func testExchangeAccessTokenForCode_failure() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

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

        let request = task!.originalRequest!
        XCTAssertEqual(request.url, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        wait(for: [tokenExpectation], timeout: 1)
    }

    // MARK: Refresh Token

    func testExchangeRefreshForAccessToken() {
        let trakt = Trakt(session: Helper.mockURLSession(json: "exchange-refresh-for-access-token"), credentials: Helper.credentials)

        // current token is expired
        trakt.token = Token(accessToken: "access-token", refreshToken: "refresh-token", expiry: .distantPast)

        let expectation = self.expectation(description: "expects refreshed token token")

        // exchange code for token
        let task = trakt.exchangeRefreshToken { (result) in
            if let token = result.value,
                token.accessToken == "dbaf9757982a9e738f05d249b7b5b4a266b3a139049317c4909f2f263572c781",
                token.refreshToken == "76ba4c5c75c96f6087f58a4de10be6c00b29ea1ddc3b2022ee2016d1363e3a7c" {
                expectation.fulfill()
            }
        }
        XCTAssertNotNil(task)

        let request = task!.originalRequest!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        wait(for: [expectation], timeout: 1)
    }

    func testExchangeRefreshForAccessToken_missingRefreshToken() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)

        // invalidate previous token
        trakt.token = nil

        let expectation = self.expectation(description: "expects missing refresh token")

        // exchange code for token
        let task = trakt.exchangeRefreshToken { (result) in
            if result.error != nil {
                expectation.fulfill()
            } else {
                XCTFail("expected error due to missing refresh token")
            }
        }

        XCTAssertNil(task)
        wait(for: [expectation], timeout: 1)
    }

    func testExchangeRefreshForAccessToken_serverError() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)
        trakt.token = Token(accessToken: "access-token", refreshToken: "refresh-token", expiry: .distantFuture)

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

        let request = task!.originalRequest!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/token"))
        XCTAssertEqual(request.httpMethod, "POST")

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Revoke Access Token

    func testRevokeAccessToken_success() {
        let trakt = Trakt(session: Helper.mockURLSession(json: "empty"), credentials: Helper.credentials)
        trakt.token = Token(accessToken: "123", refreshToken: "312", expiry: .distantFuture)

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

        let request = task!.originalRequest!
        XCTAssertEqual(request.url!, URL(string: "https://api.trakt.tv/oauth/revoke"))
        XCTAssertEqual(request.httpMethod, "POST")

        let contentType = request.allHTTPHeaderFields?["Content-Type"]
        XCTAssertEqual(contentType!, "application/x-www-form-urlencoded")

        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertEqual(body, "token=123")

        wait(for: [expectation], timeout: 1)
    }

    func testRevokeAccessToken_missingAuthorization() {
        let trakt = Trakt(session: Helper.mockURLSession(json: "empty"), credentials: Helper.credentials)

        // invalidate token
        trakt.token = nil

        let expectation = self.expectation(description: "expects missing authorization")

        let task = trakt.revokeAccessToken { (result) in
            switch result {
            case .success:
                XCTFail("Request should fail due to missing token")
            case .failure:
                expectation.fulfill()
            }
        }
        XCTAssertNil(task)

        wait(for: [expectation], timeout: 1)
    }

    func testRevokeAccessToken_serverError() {
        let trakt = Trakt(session: Helper.mockURLSession(error: .unknown), credentials: Helper.credentials)

        // invalidate token
        trakt.token = nil

        let expectation = self.expectation(description: "expects server error")

        let task = trakt.revokeAccessToken { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected result. Request should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        XCTAssertNil(task)

        wait(for: [expectation], timeout: 1)
    }
}
