//
//  TraktExplore.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func trendingShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.trendingShows(extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
  public func popularShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.popularShows(extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
  public func anticipatedShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.anticipatedShows(extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
  public func playedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.playedShows(period: period, extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
  public func watchedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.watchedShows(period: period, extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
  public func collectedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Explore.collectedShows(period: period, extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
}
