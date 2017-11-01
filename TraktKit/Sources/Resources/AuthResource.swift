//
//  Auth.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct AuthResource {
    
    // MARK: Properties
    private let credentials: Credentials
    private let configuration: Configuration
    
    // MARK: - Init
    internal init(credentials: Credentials, configuration: Configuration) {
        self.credentials = credentials
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    public func exchangeAccessToken(for code: String) -> Resource<Token> {
        let params = [
            "code": code,
            "client_id": credentials.clientID,
            "client_secret": credentials.clientSecret,
            "redirect_uri": credentials.redirectURI,
            "grant_type": "authorization_code"
        ]
        return buildResource(base: configuration.base, path: "/oauth/token", params: params, method: .post, decoder: .timeIntervalSinceNow)
    }
    
    public func refreshAccessToken(with refreshToken: String) -> Resource<Token> {
        let params = [
            "client_id"     : credentials.clientID,
            "client_secret" : credentials.clientSecret,
            "redirect_uri"  : credentials.redirectURI,
            "refresh_token" : refreshToken,
            "grant_type"    : "refresh_token"
        ]
        return buildResource(base: configuration.base, path: "/oauth/token", params: params, method: .post, decoder: .timeIntervalSinceNow)
    }
    
}
