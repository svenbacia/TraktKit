//
//  TraktSync.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func lastActivities(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/lastActivities"), authenticated: true, completion: completion)
  }
  
  public func collection(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/collection/shows", params: parameters(extended: extended)),
                authenticated: true,
                completion: completion)
  }
  
  public func watched(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/watched/shows", params: parameters(extended: extended)),
                authenticated: true,
                completion: completion)
  }
  
  public func watchlist(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/watchlist/shows", params: parameters(extended: extended)),
                authenticated: true,
                completion: completion)
  }
  
  // MARK: History
  
  public func addToHistory(items: [ContentType], completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/history", params: parameters(with: items), method: .post),
                authenticated: true,
                completion: completion)
  }
  
  public func removeFromHistory(items: [ContentType], completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/history/remove", params: parameters(with: items), method: .post),
                authenticated: true,
                completion: completion)
  }
  
}
