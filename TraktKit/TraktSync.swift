//
//  TraktSync.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func lastActivities(_ completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.lastActivities(), authenticated: true, completion: completion)
  }
    
  public func collection(_ extended: Extended? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.collection(extended),
                authenticated: true,
                completion: completion)
  }
  
  public func watched(_ extended: Extended? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.watched(extended),
                authenticated: true,
                completion: completion)
  }
  
  public func watchlist(_ extended: Extended? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.watchlist(extended),
                authenticated: true,
                completion: completion)
  }
  
  // MARK: History
  
  public func addToHistory(items: [ContentType], completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.addToHistory(items),
                authenticated: true,
                completion: completion)
  }
  
  public func removeFromHistory(items: [ContentType], completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Sync.removeFromHistory(items),
                authenticated: true,
                completion: completion)
  }
  
}
