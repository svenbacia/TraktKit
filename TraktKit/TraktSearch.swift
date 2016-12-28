//
//  TraktSearch.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum SearchType: String {
  case movie
  case show
  case episode
  case person
  case list
}

extension Trakt {
  
  public func search(for search: String, ofType type: SearchType, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/search/\(type.rawValue)", params: parameters(with: ["query" : search], page: page, limit: limit, extended: extended)),
                authenticated: false,
                completion: completion)
  }
  
}
