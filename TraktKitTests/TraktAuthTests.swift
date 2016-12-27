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
  
  var trakt: Trakt!
  
  override func setUp() {
    super.setUp()
    
    let credentials = Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI")
    trakt = Trakt(credentials: credentials)
    trakt.invalidateToken()
  }
  
  func testDefaultValues() {
    XCTAssertFalse(trakt.authorized)
    XCTAssertTrue(trakt.expired)
    XCTAssertNil(trakt.token)
  }
  
  func testManualTokenUpdate() {
    let expiry = Date().addingTimeInterval(3600)
    trakt.update(accessToken: "accessToken", refreshToken: "refreshToken", expiry: expiry)
    XCTAssertTrue(trakt.authorized)
    XCTAssertFalse(trakt.expired)
    XCTAssertEqual(trakt.token!.accessToken, "accessToken")
    XCTAssertEqual(trakt.token!.refreshToken, "refreshToken")
    XCTAssertEqual(trakt.token!.expiry, expiry)
  }
  
}
