//
//  PaginationTests.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

class PaginationTests: XCTestCase {

    func testPagination_success() {
        let headers = [
            "x-pagination-page": "1",
            "x-pagination-limit": "10",
            "x-pagination-page-count": "10",
            "x-pagination-item-count": "100"
        ]
        let pagination = Pagination(headers: headers)
        XCTAssertEqual(pagination!.page, 1)
        XCTAssertEqual(pagination!.limit, 10)
        XCTAssertEqual(pagination!.numberOfPages, 10)
        XCTAssertEqual(pagination!.numberOfItems, 100)
    }

    func testPagination_missingPage() {
        let headers = [
            "x-pagination-limit": "10",
            "x-pagination-page-count": "10",
            "x-pagination-item-count": "100"
        ]
        let pagination = Pagination(headers: headers)
        XCTAssertNil(pagination)
    }

    func testPagination_missingLimit() {
        let headers = [
            "x-pagination-page": "1",
            "x-pagination-page-count": "10",
            "x-pagination-item-count": "100"
        ]
        let pagination = Pagination(headers: headers)
        XCTAssertNil(pagination)
    }

    func testPagination_missingPageCount() {
        let headers = [
            "x-pagination-page": "1",
            "x-pagination-limit": "10",
            "x-pagination-item-count": "100"
        ]
        let pagination = Pagination(headers: headers)
        XCTAssertNil(pagination)
    }

    func testPagination_missingItemCount() {
        let headers = [
            "x-pagination-page": "1",
            "x-pagination-limit": "10",
            "x-pagination-page-count": "10"
        ]
        let pagination = Pagination(headers: headers)
        XCTAssertNil(pagination)
    }
}
