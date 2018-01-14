//
//  TokenTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class TokenTests: XCTestCase {
    
    func testCreateToken() {
        let expiry = Date()
        let token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: expiry)
        
        XCTAssertEqual(token.accessToken, "accessToken")
        XCTAssertEqual(token.refreshToken, "refreshToken")
        XCTAssertEqual(token.expiry, expiry)
    }
    
    func testIsExpired_true() {
        let token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: Date(timeIntervalSinceNow: -60))
        XCTAssertTrue(token.isExpired)
    }
    
    func testIsExpired_false() {
        let token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: Date(timeIntervalSinceNow: 3600))
        XCTAssertFalse(token.isExpired)
    }
    
    func testIsValid_true() {
        let token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: Date(timeIntervalSinceNow: 3600))
        XCTAssertTrue(token.isValid)
    }
    
    func testIsValid_false_missingAccessToken() {
        let token = Token(accessToken: "", refreshToken: "refreshToken", expiry: Date(timeIntervalSinceNow: 3600))
        XCTAssertFalse(token.isValid)
    }
    
    func testIsValid_false_expired() {
        let token = Token(accessToken: "accessToken", refreshToken: "refreshToken", expiry: Date(timeIntervalSinceNow: -3600))
        XCTAssertFalse(token.isValid)
    }

    func testLoadToken() {
        let token = Token(accessToken: "", refreshToken: "refreshToken", expiry: .distantFuture)
        let trakt = Trakt(credentials: Credentials(clientID: "", clientSecret: "", redirectURI: ""))
        trakt.token = token
        let newToken = trakt.loadToken()
        XCTAssertNotNil(newToken)
    }

    func testLoadTokenWithoutRefreshToken() {
        let token = Token(accessToken: "", refreshToken: "refreshToken", expiry: .distantFuture)
        let trakt = Trakt(credentials: Credentials(clientID: "", clientSecret: "", redirectURI: ""))
        trakt.token = token

        try! Keychain.default.set(Optional<String>.none, forKey: "trakt.refreshToken")
        let newToken = trakt.loadToken()

        XCTAssertNil(newToken)
    }

    func testLoadTokenWithoutExpiry() {
        let token = Token(accessToken: "", refreshToken: "refreshToken", expiry: .distantFuture)
        let trakt = Trakt(credentials: Credentials(clientID: "", clientSecret: "", redirectURI: ""))
        trakt.token = token

        UserDefaults.standard.set(nil, forKey: "trakt.expiry")
        let newToken = trakt.loadToken()

        XCTAssertNil(newToken)
    }
}
