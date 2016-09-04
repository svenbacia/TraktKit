//
//  Resource.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

enum Method: String, CustomStringConvertible {
  case get
  case post
  case delete
  case update
  
  public var description: String {
    return self.rawValue.uppercased()
  }
}

public struct Resource<Element> {
  
  public let request: URLRequest
  let parse: (Data) throws -> Element
  
  public init(url: URL, parse: @escaping (Data) throws -> Element) {
    self.request = URLRequest(url: url)
    self.parse   = parse
  }
  
  public init(request: URLRequest, parse: @escaping (Data) throws -> Element) {
    self.request = request
    self.parse   = parse
  }
  
}

func resource<T>(for path: String, params: [String : Any]? = nil, method: Method = .get, parse: @escaping (Data) throws -> T) -> Resource<T> {
  
  var components = URLComponents()
  components.scheme = "https"
  components.host = "api.trakt.tv"
  components.path = path
  
  if let params = params as? [String : String], method == .get {
    components.queryItems = params.map(toQueryItem)
  }
  
  var request = URLRequest(url: components.url!)
  request.httpMethod = method.description
  
  if let params = params, method == .post, let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
    request.httpBody = data
  }
  
  return Resource(request: request, parse: parse)
}

func resource<T: Unboxable>(for path: String, params: [String : Any]? = nil, method: Method = .get) -> Resource<T> {
  return resource(for: path, params: params, method: method, parse: parseWithUnbox)
}

func resource<T: Unboxable>(for path: String, params: [String : Any]? = nil, method: Method = .get) -> Resource<[T]> {
  return resource(for: path, params: params, method: method, parse: parseWithUnbox)
}

// MARK: - Parse

func parseEmpty(_ data: Data) throws -> Void {
  
}

func parseJSON(_ data: Data) throws -> Any {
  return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
}

func parseWithUnbox<T: Unboxable>(_ data: Data) throws -> T {
  return try Unbox(data: data)
}

func parseWithUnbox<T: Unboxable>(_ data: Data) throws -> [T] {
  return try Unbox(data: data)
}

func parseToken(_ data: Data) throws -> Token {
  
  guard let json = try parseJSON(data) as? [String: Any] else { throw buildError(with: .invalidResponse) }
  
  guard let refreshToken = json["refresh_token"] as? String else { throw buildError(with: .invalidJSON, reason: "Missing key refresh_token") }
  guard let expiry = json["expires_in"] as? Double else { throw buildError(with: .invalidJSON, reason: "Missing key expires_in") }
  guard let accessToken = json["access_token"] as? String else { throw buildError(with: .invalidJSON, reason: "Missing key access_token") }
  
  return Token(accessToken: accessToken, refreshToken: refreshToken, expiry: Date(timeIntervalSinceNow: expiry))
}

// MARK: - Parameters

func parameters(with params: [String : String]? = nil, page: Int? = nil, limit: Int? = nil, extended: Extended? = nil) -> [String : String]? {
  var params = params ?? [String : String]()
  
  if let page = page {
    params["page"] = String(page)
  }
  
  if let limit = limit {
    params["limit"] = String(limit)
  }
  
  extended?.parameters.forEach { (key, value) in params[key] = value }
  
  return params.count > 0 ? params : nil
}

// MARK: - Path

func path(_ path: String, with period: Period? = nil) -> String {
  guard let period = period else { return path }
  return path.appending("/\(period.rawValue)")
}
