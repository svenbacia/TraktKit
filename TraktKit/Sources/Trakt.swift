//
//  Trakt.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public typealias CompletionHandler<T> = ((Result<(T, Pagination?), TraktError>) -> Void)

public final class Trakt {
    
    // MARK: Public Properties
    
    public let credentials: Credentials
    public let configuration: Configuration
    
    public var token: Token? {
        didSet {
            persist(token)
        }
    }
    
    // MARK: - Internal Properties
    
    let keychain: Keychain
    let session: URLSession
    
    // MARK: - Initializer
    
    public init(configuration: Configuration = Configuration(), session: URLSession = URLSession.shared, credentials: Credentials, keychain: Keychain = .default) {
        self.configuration = configuration
        self.credentials = credentials
        self.keychain = keychain
        self.session = session
        self.loadToken()
    }
    
    // MARK: - Resources
    
    public var resources: Resources {
        return Resources(configuration: configuration, credentials: credentials)
    }
    
    // MARK: - Load
    
    @discardableResult
    public func load<Item>(resource: Resource<Item>, authenticated: Bool, completion: @escaping CompletionHandler<Item>) -> URLSessionTask? {
        
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
        
        if let url = request.url, configuration.isDebug {
            print("Request: \(url)")
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
                    completion(.failure(.unknownStatusCode(response.statusCode, request, error)))
                }
                return
            }
            
            guard 200...299 ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(.badStatusCode(statusCode, request, error)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseData(request, error)))
                }
                return
            }
            
            let pagination: Pagination? = {
                guard let headers = response.allHeaderFields as? [String: Any] else { return nil }
                return Pagination(headers: headers)
            }()
            
            do {
                let result = try resource.parse(data)
                DispatchQueue.main.async {
                    completion(.success((result, pagination)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseJson(error, request)))
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
    private func addTraktHeader(to request: inout URLRequest) {
        request.addValue(credentials.clientID, forHTTPHeaderField: "trakt-api-key")
        request.addValue(configuration.apiVersion, forHTTPHeaderField: "trakt-api-version")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func buildError(reason: String) -> Error {
        let dict = [
            NSLocalizedDescriptionKey: reason
        ]
        return NSError(domain: configuration.errorDomain, code: 599, userInfo: dict)
    }
}
