//
//  TraktSearch.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func search(for search: String, ofType type: SearchType, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    return load(resource: Search.for(search, ofType: type, extended: extended, page: page, limit: limit),
                authenticated: false,
                completion: completion)
  }
  
}
