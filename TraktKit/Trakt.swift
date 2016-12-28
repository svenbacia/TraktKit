//
//  Trakt.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

let TraktErrorDomain = "TraktKit"
let TraktAPIVersion = "2"

public final class Trakt {
  
  // MARK: Public Properties
  
  public let credentials: Credentials
  
  public var debug: Bool = false
  
  // MARK: - Internal Properties
  
  let keychain: Keychain
  let session: URLSession
  
  var token: Token?
  
  // MARK: - Initializer
  
  public init(credentials: Credentials) {
    self.credentials = credentials
    self.keychain = Keychain(service: "com.svenbacia.traktkit")
    
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = [
      "trakt-api-key": credentials.clientID,
      "trakt-api-version": TraktAPIVersion,
      "Content-Type": "application/json"
    ]
    self.session = URLSession(configuration: configuration)
    
    self.loadToken()
  }
  
  // MARK: - Load
  
  internal func load<Item>(resource: Resource<Item>, authenticated: Bool, completion: @escaping (Result<Item, Error>) -> Void) -> URLSessionTask? {
    
    var request = resource.request
    
    if let token = token, authenticated, token.isValid {
      request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
    }
    
    if debug {
      print("Load \(request.url!)")
    }
        
    let task = session.dataTask(with: request) { data, response, error in
      
      guard let response = response as? HTTPURLResponse else {
        DispatchQueue.main.async {
          completion(.failure(buildError(with: .undefinedError, reason: "Unknown server response")))
        }
        return
      }
      
      guard 200...299 ~= response.statusCode else {
        let error: Error
        if let statusCode = StatusCode(rawValue: response.statusCode) {
          error = buildError(with: statusCode)
        } else {
          error = buildError(with: .undefinedError)
        }
        
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      guard let data = data else {
        DispatchQueue.main.async {
          completion(.failure(buildError(with: .undefinedError, reason: "Missing data")))
        }
        return
      }
      
      do {
        let result = try resource.parse(data)
        DispatchQueue.main.async {
          completion(.success(result))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(buildError(with: .undefinedError, reason: "Could not parse response data")))
        }
      }
    }
    
    task.resume()
    
    return task
  }
  
}
