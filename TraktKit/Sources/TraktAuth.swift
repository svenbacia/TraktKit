//
//  TraktAuth.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  // MARK: Properties
  
  public var authorized: Bool {
    guard let token = token?.accessToken else { return false }
    return !token.isEmpty
  }
  
  public var expired: Bool {
    return token?.isExpired ?? true
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
  
  // MARK: - Endpoints
  
  @discardableResult
  public func exchangeAccessToken(for code: String, completion: @escaping (Result<(Token, Pagination?), TraktError>) -> Void) -> URLSessionTask? {
    return load(resource: Auth.exchangeAccessToken(for: code, credentials: credentials),
                authenticated: false) { [weak self] result in
                  switch result {
                  case .success(let token):
                    self?.token = token.0
                    self?.persist(token: token.0)
                    completion(result)
                  case .failure:
                    completion(result)
                  }
    }
  }
  
  @discardableResult
  public func exchangeRefreshToken(_ completion: @escaping (Result<(Token, Pagination?), TraktError>) -> Void) -> URLSessionTask? {
    guard let token = token else {
      completion(.failure(.invalidAuthorization))
      return nil
    }
    return load(resource: Auth.refreshAccessToken(with: token.refreshToken, credentials: credentials),
                authenticated: false) { [weak self] result in
                  switch result {
                  case .success(let token):
                    self?.token = token.0
                    self?.persist(token: token.0)
                  default: break
                  }
                  completion(result)
    }
  }
  
  // MAKR: - Token
  
  public func update(accessToken: String, refreshToken: String, expiry: Date) {
    let token = Token(accessToken: accessToken, refreshToken: refreshToken, expiry: expiry)
    persist(token: token)
    self.token = token
  }
  
  func loadToken() {
    let defaults = UserDefaults.standard
    
    guard let accessToken = keychain.string(for: Key.accessToken) else { return }
    guard let refreshToken = keychain.string(for: Key.refreshToken) else { return }
    guard let expiry = defaults.object(forKey: Key.expiry) as? Date else { return }
    
    token = Token(accessToken: accessToken, refreshToken: refreshToken, expiry: expiry)
  }
  
  public func invalidateToken() {
    token = nil
    persist(token: nil)
  }
  
}

// MARK: - Private Functions

fileprivate extension Trakt {
  
  struct Key {
    static let accessToken = "trakt.accessToken"
    static let refreshToken = "trakt.refreshToken"
    static let expiry = "trakt.expiry"
  }
  
  func persist(token: Token?) {
    keychain.set(string: token?.accessToken, forKey: Key.accessToken)
    keychain.set(string: token?.refreshToken, forKey: Key.refreshToken)
    UserDefaults.standard.set(token?.expiry, forKey: Key.expiry)
  }
  
}
