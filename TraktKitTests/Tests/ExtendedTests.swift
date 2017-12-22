//
//  ComponentsTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class ComponentsTests: XCTestCase {
    
    func testMin() {
        XCTAssertEqual(Extended.min.description, "min")
    }
    
    func testImages() {
        XCTAssertEqual(Extended.images.description, "images")
    }
    
    func testFull() {
        XCTAssertEqual(Extended.full.description, "full")
    }
    
    func testEpisodes() {
        XCTAssertEqual(Extended.episodes.description, "episodes")
    }
    
    func testFullImagesParameters() {
        let extended: Extended = [.full, .images]
        XCTAssertEqual(extended.parameters, ["extended" : "images,full"])
    }
}
