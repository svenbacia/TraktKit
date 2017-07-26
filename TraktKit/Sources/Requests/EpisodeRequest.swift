//
//  EpisodeRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct EpisodeRequest {
  
  // MARK: - Properties
  
  private let basePath: String
  
  // MARK: - Init
  
  init(show: Int, season: Int, number: Int) {
    self.basePath = "/shows/\(show)/seasons/\(season)/episodes/\(number)"
  }
  
  // MARK: - Endpoints
  
  public func summary(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: basePath, params: parameters(extended: extended))
  }
  
  public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: basePath + "/comments", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public func ratings() -> Resource<Any> {
    return resource(for: basePath + "/ratings")
  }
  
  public func stats() -> Resource<Any> {
    return resource(for: basePath + "/stats")
  }
  
  public func watching(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: basePath + "/watching", params: parameters(extended: extended))
  }
  
}
