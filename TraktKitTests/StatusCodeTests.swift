//
//  StatusCodeTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class StatusCodeTests: XCTestCase {
  
  func testRawValue() {
    XCTAssertEqual(StatusCode.success.rawValue, 200)
    XCTAssertEqual(StatusCode.successNewResourceCreated.rawValue, 201)
    XCTAssertEqual(StatusCode.successNoContentToReturn.rawValue, 204)
    
    XCTAssertEqual(StatusCode.badRequest.rawValue, 400)
    XCTAssertEqual(StatusCode.unauthorized.rawValue, 401)
    XCTAssertEqual(StatusCode.forbidden.rawValue, 403)
    XCTAssertEqual(StatusCode.notFound.rawValue, 404)
    XCTAssertEqual(StatusCode.methodNotFound.rawValue, 405)
    XCTAssertEqual(StatusCode.conflict.rawValue, 409)
    XCTAssertEqual(StatusCode.preconditionFailed.rawValue, 412)
    XCTAssertEqual(StatusCode.unprocessableEntity.rawValue, 422)
    XCTAssertEqual(StatusCode.rateLimitExceeded.rawValue, 429)
    
    XCTAssertEqual(StatusCode.serverError.rawValue, 500)
    XCTAssertEqual(StatusCode.serverOverloaded.rawValue, 503)
    XCTAssertEqual(StatusCode.gatewayTimedOut.rawValue, 504)
    XCTAssertEqual(StatusCode.cloudflareError1.rawValue, 520)
    XCTAssertEqual(StatusCode.cloudflareError2.rawValue, 521)
    XCTAssertEqual(StatusCode.cloudflareError3.rawValue, 522)
  }
  
}
