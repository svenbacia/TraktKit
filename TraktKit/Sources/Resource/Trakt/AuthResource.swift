//
//  Auth.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

struct AuthResource {

    // MARK: Properties

    private let credentials: Credentials
    private let configuration: Trakt.Configuration

    // MARK: - Init

    init(credentials: Credentials, configuration: Trakt.Configuration) {
        self.credentials = credentials
        self.configuration = configuration
    }

    // MARK: - Endpoints

    func exchangeAccessToken(for code: String) -> Resource<Token> {
        let params = [
            "code": code,
            "client_id": credentials.clientID,
            "client_secret": credentials.clientSecret,
            "redirect_uri": credentials.redirectURI,
            "grant_type": "authorization_code"
        ]
        return buildResource(base: configuration.base, path: "/oauth/token", params: params, method: .post, decoder: .timeIntervalSinceNow)
    }

    func refreshAccessToken(with refreshToken: String) -> Resource<Token> {
        let params = [
            "client_id": credentials.clientID,
            "client_secret": credentials.clientSecret,
            "redirect_uri": credentials.redirectURI,
            "refresh_token": refreshToken,
            "grant_type": "refresh_token"
        ]
        return buildResource(base: configuration.base, path: "/oauth/token", params: params, method: .post, decoder: .timeIntervalSinceNow)
    }

    func revokeAccessToken(_ accessToken: String) -> Resource<Any> {
        return buildResource(base: configuration.base, path: "/oauth/revoke", body: "token=\(accessToken)", method: .post)
    }
}
