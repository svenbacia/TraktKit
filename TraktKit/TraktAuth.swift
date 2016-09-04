//
//  TraktAuth.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public var authorized: Bool {
    guard let token = token?.accessToken else { return false }
    return !token.isEmpty
  }
  
  public var expired: Bool {
    return token?.isExpired ?? false
  }
  
  public var authorizationURL: URL? {
    guard var components = URLComponents(string: "https://www.trakt.tv/oauth/authorize") else { return nil }
    
    let parameters = [
      "response_type": "code",
      "client_id": credentials.clientID,
      "redirect_uri": credentials.redirectURI
    ]
    components.queryItems = parameters.map(toQueryItem).flatMap { $0 }
    
    return components.url
  }
  
  public func open(url: URL, completion: @escaping (Result<Bool, Error>) -> Void) -> Bool {
    
    guard let query = url.query else { return false }
    guard let code = query.components(separatedBy: "=").last else { return false }
    
    exchangeToken(with: code, completion: completion)
    
    return true
  }
  
  @discardableResult private func exchangeToken(with code: String, completion: @escaping (Result<Bool, Error>) -> Void) -> URLSessionTask? {
    let params = [
      "client_id": credentials.clientID,
      "client_secret": credentials.clientSecret,
      "redirect_uri": credentials.redirectURI,
      "code": code,
      "grant_type": "authorization_code"
    ]
    return exchangeToken(with: params, completion: completion)
  }
  
  @discardableResult private func exchangeRefreshToken(_ completion: @escaping (Result<Bool, Error>) -> Void) -> URLSessionTask? {
    
    guard let token = token else {
      completion(.failure(buildError(with: .unauthorized)))
      return nil
    }
    
    let params = [
      "client_id"     : credentials.clientID,
      "client_secret" : credentials.clientSecret,
      "redirect_uri"  : credentials.redirectURI,
      "refresh_token" : token.refreshToken,
      "grant_type"    : "refresh_token"
    ]
    return exchangeToken(with: params, completion: completion)
  }
  
  private func exchangeToken(with params: [String : Any], completion: @escaping (Result<Bool, Error>) -> Void) -> URLSessionTask? {
    let res = resource(for: "/oauth/token", params: params, method: .post, parse: parseToken)
    return load(resource: res, authenticated: true) { [weak self] result in
      switch result {
      case .success(let token):
        self?.persist(token: token)
        completion(.success(true))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
}

// MARK: - Token

extension Trakt {
  
  private struct Key {
    static let accessToken = "trakt.accessToken"
    static let refreshToken = "trakt.refreshToken"
    static let expiry = "trakt.expiry"
  }
  
  func loadToken() {
    let defaults = UserDefaults.standard
    
    guard let accessToken = keychain.string(for: Key.accessToken) else { return }
    guard let refreshToken = keychain.string(for: Key.refreshToken) else { return }
    guard let expiry = defaults.object(forKey: Key.expiry) as? Date else { return }
    
    token = Token(accessToken: accessToken, refreshToken: refreshToken, expiry: expiry)
  }
  
  fileprivate func persist(token: Token) {
    keychain.set(string: token.accessToken, forKey: Key.accessToken)
    keychain.set(string: token.refreshToken, forKey: Key.refreshToken)
    UserDefaults.standard.set(token.expiry, forKey: Key.expiry)
  }
  
}
