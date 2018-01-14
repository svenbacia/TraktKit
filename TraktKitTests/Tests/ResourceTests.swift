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
        let resource = Resource(url: URL(string: "www.trakt.tv")!, parseHandler: parseData)
        XCTAssertEqual(resource.request.url, URL(string: "www.trakt.tv")!)
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
    
    func testParseData() {
        let data = Data(base64Encoded: "Test")!
        let result = try! parseData(data, decoder: nil)
        XCTAssertEqual(data, result)
    }
    
    func testBuildResource_data() {
        let resource: Resource<Data> = buildResource(base: "https://www.trakt.tv", path: "/shows/trending")
        XCTAssertEqual(resource.request.url!.absoluteString, "https://www.trakt.tv/shows/trending")
    }

    private struct Banana: Codable {
        let name: String
    }

    func testParseResourceWithoutDecoder() {
        let resource: Resource<Banana> = Resource(url: URL(string: "www.trakt.tv")!, decoder: nil, parseHandler: parseDecodable)
        XCTAssertThrowsError(try resource.parse(Data(capacity: 8)))
    }
}
