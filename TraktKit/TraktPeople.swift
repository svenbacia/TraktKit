//
//  TraktPeople.swift
//  TraktKit
//
//  Created by Sven Bacia on 29/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  func person(_ id: Int) -> PeopleRequest {
    return PeopleRequest(id: id)
  }
  
}
