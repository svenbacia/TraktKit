//
//  ListRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ListRequest {
  
  private let user: String
  private let list: String
  private let trakt: Trakt
  
  init(user: String, id: String, trakt: Trakt) {
    self.user = user
    self.list = id
    self.trakt = trakt
  }
  
  public func summary(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/users/\(user)/lists/\(list)"),
                      authenticated: true,
                      completion: completion)
  }
  
  func items(ofType type: ListItemType, extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/users/\(user)/lists/\(list)/items/\(type)", params: parameters(extended: extended)),
                      authenticated: true,
                      completion: completion)
  }
  
  public func add(items: [ContentType], completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/users/\(user)/lists/\(list)/items", params: parameters(with: items), method: .post),
                      authenticated: true,
                      completion: completion)
  }
  
  public func remove(items: [ContentType], completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/users/\(user)/lists/\(list)/items/remove", params: parameters(with: items), method: .post),
                      authenticated: true,
                      completion: completion)
  }
  
}
