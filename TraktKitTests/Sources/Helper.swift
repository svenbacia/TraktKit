//
//  Helper.swift
//  TraktKitTests
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import XCTest
import TraktKit

public struct Helper {
    public static let credentials = Credentials(clientID: "clientID", clientSecret: "clientSecret", redirectURI: "redirectURI")
    public static let httpUrlResponse = HTTPURLResponse(url: URL(string: "www.trakt.tv")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
}
