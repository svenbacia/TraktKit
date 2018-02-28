//
//  Resource+Request.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func buildRequest(base: String, path: String, params: [String: Any]?, method: Method) -> URLRequest {
    func body(from params: [String: Any]?, method: Method) -> Data? {
        guard let params = params, method.allowsHttpBody else { return nil }
        return try? JSONSerialization.data(withJSONObject: params, options: [])
    }
    return buildRequest(base: base, path: path, params: params, body: body(from: params, method: method), method: method)
}

func buildRequest(base: String, path: String, params: [String: Any]?, body: Data?, method: Method) -> URLRequest {
    guard var components = URLComponents(string: base) else { fatalError("unexpected url components") }
    components.path = path

    if let params = params as? [String: String], method == .get {
        components.queryItems = params.map(toQueryItem)
    }

    guard let url = components.url else { fatalError("could not build url with path: \(path)") }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    if let body = body, method.allowsHttpBody {
        request.httpBody = body
    }

    return request
}
