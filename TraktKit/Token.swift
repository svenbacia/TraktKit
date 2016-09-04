//
//  Token.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

struct Token {
  
  let accessToken: String
  let refreshToken: String
  let expiry: Date
  
  var isExpired: Bool {
    return expiry.timeIntervalSinceNow < 0
  }
  var isValid: Bool {
    return !accessToken.isEmpty && !isExpired
  }
  
}
