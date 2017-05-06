//
//  ShowRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ShowRequest {
  
  // MARK: - Properties
  
  private let id: Int
  
  // MARK: - Init
  
  init(id: Int) {
    self.id = id
  }
  
  // MARK: - Endpoints
  
  public func summary(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)", params: parameters(extended: extended))
  }
  
  public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)/comments", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public func people(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)/people", params: parameters(extended: extended))
  }
  
  public func ratings() -> Resource<Any> {
    return resource(for: "/shows/\(id)/rating")
  }
  
  public func related(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)/related", params: parameters(page: page, limit: limit, extended: extended))
  }
  
  public func stats() -> Resource<Any> {
    return resource(for: "/shows/\(id)/stats")
  }
  
  public func watching(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)/watching", params: parameters(extended: extended))
  }
  
  public func collectionProgress() -> Resource<Any> {
    return resource(for: "/shows/\(id)/progress/collection")
  }
  
  public func watchedProgress() -> Resource<Any> {
    return resource(for: "/shows/\(id)/progress/watched")
  }
  
  // MARK: - Seasons
  
  public func seasons(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/shows/\(id)/seasons", params: parameters(extended: extended))
  }
  
  public func season(_ number: Int) -> SeasonRequest {
    return SeasonRequest(id: id, number: number)
  }
  
}
