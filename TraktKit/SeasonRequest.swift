//
//  SeasonRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct SeasonRequest {
  
  private let show: String
  private let season: Int
  
  private let basePath: String
  
  init(id: String, number: Int) {
    
    self.show   = id
    self.season = number
    
    self.basePath = "/shows/\(id)/seasons/\(number)"
  }
  
  public func summary(_ extended: Extended? = nil) -> Resource<[Episode]> {
    return resource(for: basePath, params: parameters(extended: extended))
  }
  
  public func comments(_ page: Int? = nil, limit: Int? = nil) -> Resource<[Comment]> {
    return resource(for: basePath + "/comments", params: parameters(page: page, limit: limit))
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
  
  public func episode(_ number: Int) -> EpisodeRequest {
    return EpisodeRequest(show: show, season: season, number: number)
  }
  
}
