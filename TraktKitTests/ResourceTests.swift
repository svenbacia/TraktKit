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
    
    func testResource_InitWithURL() {
        let resource = Resource(url: URL(string: "https://www.unittest.org")!, parse: parseJSON)
        XCTAssertEqual(resource.request.url, URL(string: "https://www.unittest.org")!)
    }
    
    func testResourceCreate_get() {
        let params = [
            "show": "12345"
        ]
        let res: Resource<Data> = resource(for: "/show", params: params)
        XCTAssertEqual(res.request.url?.absoluteString, "https://api.trakt.tv/show?show=12345")
        XCTAssertEqual(res.request.httpMethod, "GET")
        XCTAssertNil(res.request.httpBody)
    }
    
    func testResourceCreate_post() {
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
    
    func testParameters_withParams() {
        let params = parameters(with: ["test": "123"])
        XCTAssertNotNil(params)
        XCTAssertEqual(params!["test"], "123")
    }
    
    func testParameters_withLimitPage() {
        let params = parameters(page: 12, limit: 30)
        XCTAssertNotNil(params)
        XCTAssertEqual(params!["page"], "12")
        XCTAssertEqual(params!["limit"], "30")
    }
    
    func testParameters_extended() {
        let params = parameters(extended: [.episodes, .full, .images])
        XCTAssertNotNil(params)
        XCTAssertEqual(params!["extended"], "images,full,episodes")
    }
    
    func testParameters_empty() {
        let params = parameters()
        XCTAssertNil(params)
    }
    
    func testPath_withPeriod() {
        let result = path("/show", with: Period.weekly)
        XCTAssertEqual(result, "/show/weekly")
    }
    
    func testPath_withoutPeriod() {
        let result = path("/show")
        XCTAssertEqual(result, "/show")
    }
}
