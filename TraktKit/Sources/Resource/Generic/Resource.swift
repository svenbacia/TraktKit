//
//  Resource.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Resource<Element> {

    // MARK: - Types

    public enum Error: Swift.Error {
        case missingDecoder
    }

    // MARK: - Properties

    /// URL Request
    public let request: URLRequest

    /// JSON Decoder
    public let decoder: JSONDecoder?

    /// Parse closure will be called with data returned from server.
    private let parseHandler: (Data, JSONDecoder?) throws -> Element

    // MARK: - Init
    public init(request: URLRequest, decoder: JSONDecoder? = nil, parseHandler: @escaping (Data, JSONDecoder?) throws -> Element) {
        self.request = request
        self.parseHandler = parseHandler
        self.decoder = decoder
    }

    public init(url: URL, decoder: JSONDecoder? = nil, parseHandler: @escaping (Data, JSONDecoder?) throws -> Element) {
        self.request = URLRequest(url: url)
        self.parseHandler = parseHandler
        self.decoder = decoder
    }

    // MARK: - Actions
    public func parse(_ data: Data) throws -> Element {
        return try parseHandler(data, decoder)
    }
}
