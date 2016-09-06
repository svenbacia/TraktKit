//
//  TraktUser.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func getUser(with id: String) -> UserRequest {
    return UserRequest(id: id)
  }
  
}
