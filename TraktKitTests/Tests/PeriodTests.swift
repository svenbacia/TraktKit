//
//  PeriodTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class PeriodTests: XCTestCase {
    func testDefaultPeriod() {
        XCTAssertEqual(Period.default, .weekly)
    }
}
