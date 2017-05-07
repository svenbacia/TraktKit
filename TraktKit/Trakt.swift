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
    public internal(set) var token: Token?
    
    public var isDebug: Bool
    
    // MARK: - Internal Properties
    
    let keychain: Keychain
    let session: URLSession
    
    // MARK: - Initializer
    
    public init(credentials: Credentials, session: URLSession = URLSession.shared, isDebug: Bool = false) {
        self.credentials = credentials
        self.keychain = Keychain(service: "com.svenbacia.traktkit")
        self.isDebug = isDebug
        self.session = session
        self.loadToken()
    }
    
    // MARK: - Load
    
    public func load<Item>(resource: Resource<Item>, authenticated: Bool, completion: @escaping (Result<Item, TraktError>) -> Void) -> URLSessionTask? {
        
        var request = resource.request
        
        addTraktHeader(to: &request)
        
        if authenticated {
            if let token = token, token.isValid {
                request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
            } else {
                completion(.failure(.invalidAuthorization))
                return nil
            }
        }
        
        if isDebug {
            print("Load \(request.url!)")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.unknownServerResponse(error)))
                }
                return
            }
            
            guard let statusCode = StatusCode(rawValue: response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.unknownStatusCode(response.statusCode, response.url, error)))
                }
                return
            }
            
            guard 200...299 ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(.badStatusCode(statusCode, response.url, error)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseData(response.url, error)))
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
                    completion(.failure(.invalidResponseJson(error, response.url)))
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
    private func addTraktHeader(to request: inout URLRequest) {
        request.addValue(credentials.clientID, forHTTPHeaderField: "trakt-api-key")
        request.addValue(TraktAPIVersion, forHTTPHeaderField: "trakt-api-version")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
