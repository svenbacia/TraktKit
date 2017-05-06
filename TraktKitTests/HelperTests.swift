//
//  HelperTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class HelperTests: XCTestCase {
  
  func testToQueryItem() {
    let item = toQueryItem(key: "key", value: "value")
    XCTAssertEqual(item, URLQueryItem(name: "key", value: "value"))
  }
  
  func testBuildError_withoutReason() {
    let error = buildError(with: .badRequest)
    XCTAssertNotNil(error.localizedDescription)
  }
  
  func testBuildError_withReason() {
    let error = buildError(with: .badRequest, reason: "Some custom reason")
    XCTAssertEqual(error.localizedDescription, "Some custom reason")
  }
  
}
