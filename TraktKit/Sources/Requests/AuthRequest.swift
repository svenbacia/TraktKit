//
//  AuthRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public final class AuthRequest {
    
    // MARK: - Properties
    
    private let trakt: Trakt
    
    // MARK: - Init
    
    internal init(trakt: Trakt) {
        self.trakt = trakt
    }
    
    // MARK: - Endpoints
    
    public func exchangeAccessToken(`for` code: String, completion: @escaping (Result<Token, TraktError>) -> Void) -> URLSessionTask? {
        let resource = AuthResource(credentials: trakt.credentials, configuration: trakt.configuration).exchangeAccessToken(for: code)
        return trakt.load(resource: resource, authenticated: false) { [weak self] (result) in
            switch result {
            case .success(let objects):
                let token = objects.0
                self?.trakt.token = token
                self?.trakt.persist(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func exchangeRefreshToken(_ completion: @escaping (Result<Token, TraktError>) -> Void) -> URLSessionTask? {
        guard let refreshToken = trakt.token?.refreshToken else {
            completion(.failure(TraktError.missingRefreshToken))
            return nil
        }
        let resource = AuthResource(credentials: trakt.credentials, configuration: trakt.configuration).refreshAccessToken(with: refreshToken)
        return trakt.load(resource: resource, authenticated: false) { [weak self] (result) in
            switch result {
            case .success(let objects):
                let token = objects.0
                self?.trakt.token = token
                self?.trakt.persist(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
