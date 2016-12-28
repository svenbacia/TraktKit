//
//  Auth.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Auth {
  
  public static func exchangeAccessToken(for code: String, credentials: Credentials) -> Resource<Token> {
    let params = [
      "code": code,
      "client_id": credentials.clientID,
      "client_secret": credentials.clientSecret,
      "redirect_uri": credentials.redirectURI,
      "grant_type": "authorization_code"
    ]
    return resource(for: "/oauth/token", params: params, method: .post, parse: parseToken)
  }
  
  public static func refreshAccessToken(with refreshToken: String, credentials: Credentials) -> Resource<Token> {
    let params = [
      "client_id"     : credentials.clientID,
      "client_secret" : credentials.clientSecret,
      "redirect_uri"  : credentials.redirectURI,
      "refresh_token" : refreshToken,
      "grant_type"    : "refresh_token"
    ]
    return resource(for: "/oauth/token", params: params, method: .post, parse: parseToken)
  }
  
}
