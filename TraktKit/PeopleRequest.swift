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
  
  init(id: String) {
    basePath = "/people/\(id)"
  }
  
  public func summary(_ extended: Extended? = nil) -> Resource<Person> {
    return resource(for: basePath, params: parameters(extended: extended))
  }
  
  public func shows(_ extended: Extended? = nil) -> Resource<PersonRelated> {
    return resource(for: basePath + "/shows", params: parameters(extended: extended))
  }
  
}
