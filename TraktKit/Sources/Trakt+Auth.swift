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
    
    public var auth: AuthRequest {
        return AuthRequest(trakt: self)
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
    
    func loadToken() {
        do {
            guard let accessToken = try keychain.string(forKey: Key.accessToken) else { return }
            guard let refreshToken = try keychain.string(forKey: Key.refreshToken) else { return }
            guard let expiry = UserDefaults.standard.object(forKey: Key.expiry) as? Date else { return }
            token = Token(accessToken: accessToken, refreshToken: refreshToken, expiry: expiry)
        } catch {
            token = nil
        }
    }
}
