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
  
  private let id: String
  private let trakt: Trakt
  
  // MARK: - Init
  
  init(id: String, trakt: Trakt) {
    self.id = id
    self.trakt = trakt
  }
  
  // MARK: - Endpoints
  
  public func summary(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/comments", params: parameters(page: page, limit: limit, extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func people(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/people", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func ratings(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/rating"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func related(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/related", params: parameters(page: page, limit: limit, extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func stats(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/stats"),
                      authenticated: false,
                      completion: completion)
  }
  
  public func watching(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/watching", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func collectionProgress(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/progress/collection"),
                      authenticated: true,
                      completion: completion)
  }
  
  public func watchedProgress(_ completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/progress/watched"),
                      authenticated: true,
                      completion: completion)
  }
  
  // MARK: - Seasons
  
  public func seasons(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: "/shows/\(id)/seasons", params: parameters(extended: extended)),
                      authenticated: false,
                      completion: completion)
  }
  
  public func season(_ number: Int) -> SeasonRequest {
    return SeasonRequest(id: id, number: number, trakt: trakt)
  }
  
}
