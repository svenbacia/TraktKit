//
//  SeasonRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct SeasonRequest {
  
  // MARK: - Properties
  
  private let trakt: Trakt
  
  private let show: String
  private let season: Int
  private let basePath: String
  
  // MARK: - Init
  
  init(id: String, number: Int, trakt: Trakt) {
    self.show = id
    self.season = number
    self.basePath = "/shows/\(id)/seasons/\(number)"
    self.trakt = trakt
  }
  
  // MARK: - Endpoints
  
  public func summary(_ extended: Extended? = nil, completion: @escaping (Result<[Episode], Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath, params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func comments(_ page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<[Comment], Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/comments", params: parameters(page: page, limit: limit)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func ratings(_ completion: @escaping (Result<Rating, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/ratings"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func stats(_ completion: @escaping (Result<Stats, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/stats"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func watching(_ extended: Extended? = nil, completion: @escaping (Result<[User], Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/watching", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  // MARK: - Episode Request
  
  public func episode(_ number: Int) -> EpisodeRequest {
    return EpisodeRequest(show: show, season: season, number: number, trakt: trakt)
  }
  
}
