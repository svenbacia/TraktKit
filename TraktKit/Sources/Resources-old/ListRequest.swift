//
//  ListRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ListRequest {
  
  private let user: String
  private let list: String
  
  init(user: String, id: String) {
    self.user = user
    self.list = id
  }
  
    /**
  public func summary() -> Resource<Any> {
    return buildResource(path: "/users/\(user)/lists/\(list)")
  }
  
  public func items(ofType type: ListItemType, extended: Extended? = nil) -> Resource<Any> {
    return buildResource(path: "/users/\(user)/lists/\(list)/items/\(type)", params: parameters(extended: extended))
  }
  
  public func add(items: [ContentType]) -> Resource<Any> {
    return buildResource(path: "/users/\(user)/lists/\(list)/items", params: parameters(with: items), method: .post)
  }
  
  public func remove(items: [ContentType]) -> Resource<Any> {
    return buildResource(path: "/users/\(user)/lists/\(list)/items/remove", params: parameters(with: items), method: .post)
  }
  */
}
