//
//  Token.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

/// OAuth token.
public struct Token: Codable {
    
    // MARK: - Types
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiry = "expires_in"
    }
    
    // MARK: - Init
    
    init(accessToken: String, refreshToken: String, expiry: Date) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiry = expiry
    }
    
    // MARK: - Properties
    
    /// Access token.
    public let accessToken: String
    
    /// Refresh token.
    public let refreshToken: String
    
    /// Token expiry.
    public let expiry: Date
    
    /// Returns if access token is expired.
    public var isExpired: Bool {
        return expiry.timeIntervalSinceNow < 0
    }
    
    /// The oauth token is valid when there is a non empty access token
    /// which is not expired.
    public var isValid: Bool {
        return !accessToken.isEmpty && !isExpired
    }
}

extension Token: Equatable {
    public static func ==(lhs: Token, rhs: Token) -> Bool {
        return lhs.accessToken == rhs.accessToken &&
            lhs.refreshToken == rhs.refreshToken &&
            lhs.expiry == rhs.expiry
    }
}
