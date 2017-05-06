//
//  ResourceTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ResourceTests: XCTestCase {
  
  func testResourceCreate() {
    let params = [
      "code": "code",
      "client_id": "clientid",
      "client_secret": "clientsecret",
      "redirect_uri": "redirecturi",
      "grant_type": "authorization_code"
    ]
    let res = resource(for: "/oauth/token", params: params, method: .post, parse: parseToken)
    XCTAssertEqual(res.request.url?.absoluteString, "https://api.trakt.tv/oauth/token")
    XCTAssertEqual(res.request.httpMethod, "POST")
    XCTAssertNotNil(res.request.httpBody)
  }
  
}
