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

    public var isAuthorized: Bool {
        guard let token = token else { return false }
        return token.isValid
    }

    public var isExpired: Bool {
        return token?.isExpired ?? true
    }

    public var authorizationURL: URL {
        var components = URLComponents(string: "https://www.trakt.tv/oauth/authorize")!

        let parameters = [
            "response_type": "code",
            "client_id": credentials.clientID,
            "redirect_uri": credentials.redirectURI
        ]
        components.queryItems = parameters.map(toQueryItem).flatMap { $0 }

        return components.url!
    }

    // MARK: - Endpoints

    @discardableResult
    public func exchangeAccessToken(`for` code: String, completion: @escaping (Result<Token, Error>) -> Void) -> URLSessionTask? {
        let resource = AuthResource(credentials: credentials, configuration: configuration).exchangeAccessToken(for: code)
        return load(resource: resource, authenticated: false) { [weak self] (result) in
            switch result {
            case .success(let objects):
                let token = objects.0
                self?.token = token
                self?.persist(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    public func exchangeRefreshToken(_ completion: @escaping (Result<Token, Error>) -> Void) -> URLSessionTask? {
        guard let refreshToken = token?.refreshToken else {
            completion(.failure(Error.missingAuthorization))
            return nil
        }
        let resource = AuthResource(credentials: credentials, configuration: configuration).refreshAccessToken(with: refreshToken)
        return load(resource: resource, authenticated: false) { [weak self] (result) in
            switch result {
            case .success(let objects):
                let token = objects.0
                self?.token = token
                self?.persist(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Internet Token Helper

internal extension Trakt {

    private struct Key {
        static let accessToken = "trakt.accessToken"
        static let refreshToken = "trakt.refreshToken"
        static let expiry = "trakt.expiry"
    }

    func persist(_ token: Token?) {
        try? keychain.set(token?.accessToken, forKey: Key.accessToken)
        try? keychain.set(token?.refreshToken, forKey: Key.refreshToken)
        UserDefaults.standard.set(token?.expiry, forKey: Key.expiry)
    }

    func loadToken() -> Token? {
        do {
            guard let accessToken = try keychain.string(forKey: Key.accessToken) else {
                return nil
            }
            guard let refreshToken = try keychain.string(forKey: Key.refreshToken) else {
                return nil
            }
            guard let expiry = UserDefaults.standard.object(forKey: Key.expiry) as? Date else {
                return nil
            }
            return Token(accessToken: accessToken, refreshToken: refreshToken, expiry: expiry)
        } catch {
            return nil
        }
    }
}
