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
  
  public func summary() -> Resource<List> {
    return resource(for: "/users/\(user)/lists/\(list)")
  }
  
}
