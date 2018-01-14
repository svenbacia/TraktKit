//
//  Resource+Request.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func buildRequest(base: String, path: String, params: [String: Any]?, method: Method) -> URLRequest {
    guard var components = URLComponents(string: base) else { fatalError("unexpected url components") }
    components.path = path
    
    if let params = params as? [String: String], method == .get {
        components.queryItems = params.map(toQueryItem)
    }
    
    guard let url = components.url else { fatalError("could not build url with path: \(path)") }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    if let params = params, method.allowsHttpBody  {
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    }
    
    return request
}
