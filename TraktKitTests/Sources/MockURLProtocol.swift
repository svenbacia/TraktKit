//
//  MockURLProtocol.swift
//  TraktKitTests
//
//  Created by Bacia, Sven on 19.06.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public final class MockURLProtocol: URLProtocol {

    // MARK: - Properties

    public static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    // MARK: - URL Protocol

    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        guard let requestHandler = type(of: self).requestHandler else {
            fatalError("Received unexpected request with no handler set")
        }

        do {
            let (response, data) = try requestHandler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    public override func stopLoading() {
        // handle canceled requests?
    }
}

extension MockURLProtocol {
    public static func requestHandler(statusCode: Int, data: Data) {
        requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
    }

    public static func requestHandler(error: Error) {
        requestHandler = { _ in
            throw error
        }
    }
}
