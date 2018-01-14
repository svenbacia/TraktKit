//
//  Resource+Factory.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func buildResource<T: Decodable>(base: String, path: String, params: [String : Any]? = nil, method: Method = .get, decoder: JSONDecoder = .trakt) -> Resource<T> {
    return Resource(request: buildRequest(base: base, path: path, params: params, method: method), decoder: decoder, parseHandler: parseDecodable)
}

func buildResource<T>(base: String, path: String, params: [String : Any]? = nil, method: Method = .get, parse: @escaping (Data, JSONDecoder?) throws -> T) -> Resource<T> {
    return Resource(request: buildRequest(base: base, path: path, params: params, method: method), parseHandler: parse)
}

func buildResource(base: String, path: String, params: [String : Any]? = nil, method: Method = .get) -> Resource<Any> {
    return buildResource(base: base, path: path, params: params, method: method, parse: parseJSON)
}

func buildResource(base: String, path: String, params: [String : Any]? = nil, method: Method = .get) -> Resource<Data> {
    return buildResource(base: base, path: path, params: params, method: method, parse: parseData)
}
