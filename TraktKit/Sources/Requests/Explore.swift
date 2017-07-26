//
//  Explore.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Explore {
  
  public static func trendingShows(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: "/shows/trending", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public static func popularShows(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: "/shows/popular", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public static func anticipatedShows(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: "/shows/anticipated", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public static func playedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: path("/shows/played", with: period), params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public static func watchedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: path("/shows/watched", with: period), params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public static func collectedShows(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: path("/shows/collected", with: period), params: parameters(page: page, limit: limit, extended: extended))
  }
  
}
