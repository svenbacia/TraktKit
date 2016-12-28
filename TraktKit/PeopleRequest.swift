//
//  PeopleRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct PeopleRequest {
  
  private let basePath: String
  private let trakt: Trakt
  
  init(id: String, trakt: Trakt) {
    self.basePath = "/people/\(id)"
    self.trakt = trakt
  }
  
  public func summary(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath, params: parameters(extended: extended)),
                      authenticated: true,
                      completion: completion)
  }
  
  public func shows(_ extended: Extended? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return trakt.load(resource: resource(for: basePath + "/shows", params: parameters(extended: extended)),
                      authenticated: true,
                      completion: completion)
  }
  
}
