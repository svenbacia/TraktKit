//
//  ISO8601DateFormatterTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ISO8601DateFormatterTests: XCTestCase {
  
  func testDateFormat() {
    let dateFormatter = TraktKit.ISO8601DateFormatter.default
    XCTAssertEqual(dateFormatter.dateFormat, "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
  }
  
}
