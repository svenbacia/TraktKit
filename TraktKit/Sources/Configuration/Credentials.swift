//
//  Credentials.swift
//  TraktKit
//
//  Created by Sven Bacia on 03.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

/// Trakt.tv API credentials.
public struct Credentials {

    /// Client ID.
    public let clientID: String

    /// Client Secret.
    public let clientSecret: String

    /// Redirect URI.
    public let redirectURI: String

    /// Creates a trakt.tv api credentials object with client id, client secret and
    /// redirect uri.
    ///
    /// - Parameters:
    ///   - clientID: Client ID.
    ///   - clientSecret: Client Secret.
    ///   - redirectURI: Redirect URI.
    public init(clientID: String, clientSecret: String, redirectURI: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
}
