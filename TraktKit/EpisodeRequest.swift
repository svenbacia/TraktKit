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
  
  private let trakt: Trakt
  private let basePath: String
  
  // MARK: - Init
  
  init(show: String, season: Int, number: Int, trakt: Trakt) {
    self.trakt = trakt
    self.basePath = "/shows/\(show)/seasons/\(season)/episodes/\(number)"
  }
  
  // MARK: - Endpoints
  
  public func summary(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath, params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/comments", params: parameters(page: page, limit: limit, extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func ratings(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/ratings"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func stats(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/stats"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func watching(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/watching", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
}
