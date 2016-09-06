//
//  EpisodeRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct EpisodeRequest {
  
  private let basePath: String
  
  init(show: String, season: Int, number: Int) {
    basePath = "/shows/\(show)/seasons/\(season)/episodes/\(number)"
  }
  
  public func summary(_ extended: Extended? = nil) -> Resource<Episode> {
    return resource(for: basePath, params: parameters(extended: extended))
  }
  
  public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[Comment]> {
    return resource(for: basePath + "/comments", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public func ratings() -> Resource<Rating> {
    return resource(for: basePath + "/ratings")
  }
  
  public func stats() -> Resource<Stats> {
    return resource(for: basePath + "/stats")
  }
  
  public func watching(_ extended: Extended? = nil) -> Resource<[User]> {
    return resource(for: basePath + "/watching", params: parameters(extended: extended))
  }
}
