//
//  Trakt.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public typealias CompletionHandler<T> = ((Result<(T, Pagination?), Trakt.Error>) -> Void)

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
    
    public init(session: URLSession = URLSession.shared, credentials: Credentials, configuration: Configuration = Configuration(), keychain: Keychain = .default) {
        self.configuration = configuration
        self.credentials = credentials
        self.keychain = keychain
        self.session = session
        self.token = loadToken()
    }
    
    // MARK: - Resources
    
    public var resources: Resources {
        return Resources(configuration: configuration, credentials: credentials)
    }
    
    // MARK: - Load
    
    @discardableResult
    public func load<Item>(resource: Resource<Item>, authenticated: Bool, completion: @escaping CompletionHandler<Item>) -> URLSessionTask? {
        
        var request = resource.request

        // add required header information
        addTraktHeader(to: &request)

        // add authorization information when required
        if authenticated {
            if let token = token {
                if token.isValid {
                    request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
                } else {
                    completion(.failure(Error.invalidAuthorization))
                    return nil
                }
            } else {
                completion(.failure(Error.missingAuthorization))
                return nil
            }
        }

        // print url when in debug mode
        if let url = request.url, configuration.isDebug {
            print("Request: \(url)")
        }

        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(Error.unknownServerResponse(error)))
                }
                return
            }
            
            guard let statusCode = StatusCode(rawValue: response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(Error.unknownHttpStatusCode(response, error)))
                }
                return
            }
            
            guard 200...299 ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(Error.badHttpStatusCode(statusCode, error)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(Error.missingResponseData(response, error)))
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
                    completion(.failure(Error.jsonDecodingError(error)))
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
}
