//
//  TraktExplore.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum Period: String {
  case weekly
  case monthly
  case yearly
  case all
  
  static var defaultPeriod: Period {
    return .weekly
  }
}

public enum ExploreType {
  case trending
  case popular
  case played(Period)
  case watched(Period)
  case collected(Period)
  case anticipated
}

extension Trakt {
  
  public func trendingShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[TrendingShow], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/shows/trending", params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
  public func popularShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[Show], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/shows/popular", params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
  public func anticipatedShows(extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[AnticipatedShow], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/shows/anticipated", params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
  public func playedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[Show], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: path("/shows/played", with: period), params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
  public func watchedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[Show], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: path("/shows/watched", with: period), params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
  public func collectedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[Show], Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: path("/shows/collected", with: period), params: parameters(page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
}
