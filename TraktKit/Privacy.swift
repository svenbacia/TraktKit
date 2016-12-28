//
//  Privacy.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum Privacy: String, CustomStringConvertible {
  case `private`
  case friends
  case `public`
  
  public var description: String {
    return self.rawValue.lowercased()
  }
}
