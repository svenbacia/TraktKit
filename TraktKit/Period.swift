//
//  Period.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum Period: String {
  case weekly
  case monthly
  case yearly
  case all
  
  static var `default`: Period {
    return .weekly
  }
}
