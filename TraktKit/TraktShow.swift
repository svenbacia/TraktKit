//
//  TraktShow.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func show(with id: Int) -> ShowRequest {
    return ShowRequest(id: id, trakt: self)
  }
  
}
