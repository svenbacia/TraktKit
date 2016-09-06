//
//  ResultTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ResultTests: XCTestCase {
  
  func testSuccessValue() {
    let result: Result<String, Int> = Result.success("Woho!")
    XCTAssertNotNil(result.value)
    XCTAssertNil(result.error)
    XCTAssertEqual(result.value, "Woho!")
  }
  
  func testError() {
    let result: Result<String, Int> = Result.failure(404)
    XCTAssertNotNil(result.error)
    XCTAssertNil(result.value)
    XCTAssertEqual(result.error, 404)
  }
  
}
