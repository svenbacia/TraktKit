//
//  Token.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Token {
  
  public let accessToken: String
  public let refreshToken: String
  public let expiry: Date
  
  public var isExpired: Bool {
    return expiry.timeIntervalSinceNow < 0
  }
  
  public var isValid: Bool {
    return !accessToken.isEmpty && !isExpired
  }
  
}
