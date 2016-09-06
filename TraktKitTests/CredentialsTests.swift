//
//  CredentialsTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class CredentialsTests: XCTestCase {
  
  func testCreateCredentails() {
    let credentials = Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI")
    XCTAssertEqual(credentials.clientID, "clientID")
    XCTAssertEqual(credentials.clientSecret, "clientSecret")
    XCTAssertEqual(credentials.redirectURI, "redirectURI")
  }
  
}
