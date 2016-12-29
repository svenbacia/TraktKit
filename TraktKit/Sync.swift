//
//  Sync.swift
//  TraktKit
//
//  Created by Sven Bacia on 29/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Sync {
  public static func lastActivities() -> Resource<Any> {
    return resource(for: "/sync/lastActivities")
  }
  
  public static func collection(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/sync/collection/shows", params: parameters(extended: extended))
  }
  
  public static func watched(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/sync/watched/shows", params: parameters(extended: extended))
  }
  
  public static func watchlist(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: "/sync/watchlist/shows", params: parameters(extended: extended))
  }
  
  // MARK: History
  
  public static func addToHistory(_ items: [ContentType]) -> Resource<Any> {
    return resource(for: "/sync/history", params: parameters(with: items), method: .post)
  }
  
  public static func removeFromHistory(_ items: [ContentType]) -> Resource<Any> {
    return resource(for: "/sync/history/remove", params: parameters(with: items), method: .post)
  }
}
