//
//  ListRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ListRequest {
  
  fileprivate let user: String
  fileprivate let list: String
  
  init(user: String, id: String) {
    self.user = user
    self.list = id
  }
  
  public func summary() -> Resource<List> {
    return resource(for: "/users/\(user)/lists/\(list)")
  }
  
  public func showItems(_ extended: Extended? = nil) -> Resource<[ListItem<Show>]> {
    return items(ofType: .show, extended: extended)
  }
  
  public func seasonItems(_ extended: Extended? = nil) -> Resource<[ListItem<Season>]> {
    return items(ofType: .season, extended: extended)
  }
  
  public func episodeItems(_ extended: Extended? = nil) -> Resource<[ListItem<Episode>]> {
    return items(ofType: .episode, extended: extended)
  }
  
  public func add(items: [ContentType]) -> Resource<Any> {
    return resource(for: "/users/\(user)/lists/\(list)/items", params: parameters(with: items), method: .post)
  }
  
  public func remove(items: [ContentType]) -> Resource<Any> {
    return resource(for: "/users/\(user)/lists/\(list)/items/remove", params: parameters(with: items), method: .post)
  }
  
}

fileprivate extension ListRequest {
  
  func items<T: Unboxable>(ofType type: ListItemType, extended: Extended? = nil) -> Resource<[ListItem<T>]> {
    return resource(for: "/users/\(user)/lists/\(list)/items", params: parameters(extended: extended))
  }
  
}
