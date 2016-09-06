//
//  KeychainTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class KeychainTests: XCTestCase {
  
  var keychain: Keychain = Keychain(service: "com.keychain.test")
  
  private let key = "test"
  
  override func tearDown() {
    super.tearDown()
    
    keychain.deleteItem(for: key)
  }
  
  func testSetString() {
    let result = keychain.set(string: "Hallo", forKey: key)
    XCTAssertTrue(result)
  }
  
  func testGetString() {
    let result = keychain.set(string: "Hallo", forKey: key)
    XCTAssertTrue(result)
    
    if let string = keychain.string(for: key) {
      XCTAssertEqual("Hallo", string)
    } else {
      XCTFail("Keychain.string(for:) should return a valid string.")
    }
  }
  
}
