//
//  ExploreType.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum ExploreType {
  case trending
  case popular
  case played(Period)
  case watched(Period)
  case collected(Period)
  case anticipated
}
