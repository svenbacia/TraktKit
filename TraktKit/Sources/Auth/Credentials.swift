//
//  Credentials.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Credentials {
  
  public let clientID: String
  public let clientSecret: String
  public let redirectURI: String
  
  public init(clientID: String, clientSecret: String, redirectURI: String) {
    self.clientID = clientID
    self.clientSecret = clientSecret
    self.redirectURI = redirectURI
  }
  
}
