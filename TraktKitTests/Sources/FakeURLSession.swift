//
//  FakeURLSession.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation
import TraktKit

final class FakeURLSession: URLSession {

    // MARK: - Types

    private final class Task: URLSessionDataTask {

        private let completion: () -> Void

        init(completion: @escaping () -> Void) {
            self.completion = completion
            super.init()
        }

        override func resume() {
            completion()
        }
    }

    // MARK: - Properties

    private let handler: (URLRequest) -> (Data?, URLResponse?, Error?)

    var requests = [URLRequest]()
    var completedRequests = [URLRequest]()

    // MARK: - Static Helper

    static func success(statusCode: Int, json: String) -> FakeURLSession {
        return FakeURLSession(handler: { (request) -> (Data?, URLResponse?, Error?) in
            let data = buildJsonData(name: json)
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        })
    }

    static func failure(statusCode: Int) -> FakeURLSession {
        return FakeURLSession(handler: { (request) -> (Data?, URLResponse?, Error?) in
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            return (nil, response, nil)
        })
    }

    // MARK: - Init

    init(handler: @escaping (URLRequest) -> (Data?, URLResponse?, Error?)) {
        self.handler = handler
    }

    convenience init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.init { (_) -> (Data?, URLResponse?, Error?) in
            return (data, response, error)
        }
    }

    // MARK: - Task

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requests.append(request)
        return Task {
            self.completedRequests.append(request)
            let result = self.handler(request)
            completionHandler(result.0, result.1, result.2)
        }
    }

    // MARK: - Reset 

    func reset() {
        requests.removeAll()
        completedRequests.removeAll()
    }
}

func buildData(with json: Any) -> Data {
    return try! JSONSerialization.data(withJSONObject: json, options: [])
}

func buildJsonData(name: String) -> Data? {
    guard let url = Bundle(for: FakeURLSession.self).url(forResource: name, withExtension: "json") else { return nil }
    return try? Data(contentsOf: url)
}
