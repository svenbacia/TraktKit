//
//  TraktSearch.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func searchForShow(with title: String, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[SearchResult<Show>]> {
    return search(for: title, ofType: .show, extended: extended, page: page, limit: limit)
  }
  
  public func searchForEpisode(with title: String, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[SearchResult<Episode>]> {
    return search(for: title, ofType: .episode, extended: extended, page: page, limit: limit)
  }
  
  public func searchForPerson(with title: String, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[SearchResult<Person>]> {
    return search(for: title, ofType: .person, extended: extended, page: page, limit: limit)
  }
  
  public func searchForList(with title: String, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[SearchResult<List>]> {
    return search(for: title, ofType: .list, extended: extended, page: page, limit: limit)
  }
  
}

fileprivate extension Trakt {
  func search<T: Unboxable>(for search: String, ofType type: SearchType, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[T]> {
    return resource(for: "/search/\(type.rawValue)", params: parameters(with: ["query" : search], page: page, limit: limit, extended: extended))
  }
}
