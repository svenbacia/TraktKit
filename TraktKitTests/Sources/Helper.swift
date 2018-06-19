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

    public static func mockURLSession(statusCode: Int = 200, json: String) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler(statusCode: statusCode, data: buildJsonData(name: json))
        let session = URLSession(configuration: configuration)
        return session
    }

    public static func mockURLSession(statusCode: Int, data: Data) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler(statusCode: statusCode, data: data)
        let session = URLSession(configuration: configuration)
        return session
    }

    public static func mockURLSession(error: Error) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler(error: error)
        let session = URLSession(configuration: configuration)
        return session
    }

    public enum Error: Swift.Error {
        case unknown
    }
}

func buildJsonData(name: String) -> Data {
    guard let url = Bundle(for: MockURLProtocol.self).url(forResource: name, withExtension: "json") else {
        fatalError("Unexpected resource \(name).json")
    }
    return try! Data(contentsOf: url)
}
