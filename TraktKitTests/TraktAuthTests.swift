//
//  TraktAuthTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class TraktAuthTests: XCTestCase {
    
    let credentials = Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI")
        
    func testManualTokenUpdate() {
        let trakt = Trakt(credentials: credentials)
        let expiry = Date().addingTimeInterval(3600)
        trakt.update(accessToken: "accessToken", refreshToken: "refreshToken", expiry: expiry)
        XCTAssertTrue(trakt.authorized)
        XCTAssertFalse(trakt.expired)
        XCTAssertEqual(trakt.token!.accessToken, "accessToken")
        XCTAssertEqual(trakt.token!.refreshToken, "refreshToken")
        XCTAssertEqual(trakt.token!.expiry, expiry)
    }
    
    func testAuthorizationURL() {
        let url = URL(string: "https://www.trakt.tv/oauth/authorize?redirect_uri=redirectURI&response_type=code&client_id=clientID")!
        XCTAssertEqual(Trakt(credentials: credentials).authorizationURL!, url)
    }
    
    // MARK: - Access Token
    
    func testExchangeAccessToken_success() {
        let waiter = XCTWaiter()
        let tokenExpectation = expectation(description: "auth token expected")
        
        let session = FakeURLSession { request in
            let data = buildData(with: [ "refresh_token": "refresh", "expires_in": 3600, "access_token": "access" ])
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        let trakt = Trakt(credentials: credentials, session: session)
        let task = trakt.exchangeAccessToken(for: "123") { result in
            if result.value != nil {
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
    
    func testExchangeAccessToken_failureEmptyJSON() {
        let waiter = XCTWaiter()
        let errorExpectation = expectation(description: "error expected")
        
        let session = FakeURLSession { request in
            let data = buildData(with: [:])
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        let trakt = Trakt(credentials: credentials, session: session)
        trakt.exchangeAccessToken(for: "123") { result in
            if result.error != nil {
                errorExpectation.fulfill()
            }
        }
        
        let result = waiter.wait(for: [errorExpectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    // MARK: - Refresh Token
    
    func testExchangeRefreshToken_missingAccessToken() {
        let waiter = XCTWaiter()
        let errorExpectation = expectation(description: "invalid authorization error expected")
        
        let session = FakeURLSession { _ in return (nil, nil, nil) }
        
        let trakt = Trakt(credentials: credentials, session: session)
        trakt.invalidateToken()
        
        XCTAssertFalse(trakt.authorized)
        XCTAssertTrue(trakt.expired)
        
        let task = trakt.exchangeRefreshToken { result in
            if let error = result.error {
                switch error {
                case .invalidAuthorization:
                    errorExpectation.fulfill()
                default: break
                }
            }
        }
        XCTAssertNil(task)
        XCTAssertNil(session.completedRequests.first)
        XCTAssertNil(session.requests.first)
        
        let result = waiter.wait(for: [errorExpectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testExchangeRefreshToken_success() {
        let waiter = XCTWaiter()
        let expectation = self.expectation(description: "expects refreshed access token")
        
        let session = FakeURLSession { request in
            let data = buildData(with: [ "refresh_token": "refresh", "expires_in": 3600, "access_token": "access" ])
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        let trakt = Trakt(credentials: credentials, session: session)
        
        let expiry = Date().addingTimeInterval(3600)
        trakt.update(accessToken: "accessToken", refreshToken: "refreshToken", expiry: expiry)
        
        let task = trakt.exchangeRefreshToken { result in
            if let token = result.value, token.accessToken == "access", token.refreshToken == "refresh" {
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
}
