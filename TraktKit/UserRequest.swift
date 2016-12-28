//
//  UserRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct UserRequest {
  
  // MARK: - Properties
  
  private let id: String
  private let trakt: Trakt
  
  private var basePath: String {
    return "/users/\(id)"
  }
  
  // MARK: - Init
  
  init(id: String, trakt: Trakt) {
    self.id = id
    self.trakt = trakt
  }
  
  // MARK: - Endpoints
  
  public func profile(_ extended: Extended? = nil) -> Resource<Any> {
    return resource(for: basePath, params: parameters(extended: extended))
  }
  
  public func stats() -> Resource<Any> {
    return resource(for: basePath + "/stats")
  }
  
  // MARK: Lists
  
  public func lists() -> Resource<Any> {
    return resource(for: basePath + "/lists")
  }
  
  public func createList(with name: String, description: String? = nil, privacy: Privacy? = nil, displayNumbers: Bool? = nil, allowComments: Bool? = nil, completion: @escaping (Result<Any, Error>) -> Void) -> URLSessionTask? {
    
    var body: [String : Any] = [
      "name": name
    ]
    
    if let description = description {
      body["description"] = description
    }
    
    if let privacy = privacy {
      body["privacy"] = privacy.description
    }
    
    if let displayNumbers = displayNumbers {
      body["display_numbers"] = displayNumbers
    }
    
    if let allowComments = allowComments {
      body["allow_comments"] = allowComments
    }
    
    return trakt.load(resource: resource(for: basePath + "/lists", params: body, method: .post), authenticated: true, completion: completion)
  }
  
  public func list(with name: String) -> ListRequest {
    return ListRequest(user: id, id: name, trakt: trakt)
  }
  
}
