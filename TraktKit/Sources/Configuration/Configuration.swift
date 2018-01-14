//
//  Configuration.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Configuration {

    public let base: String
    public let apiVersion: String
    public let errorDomain: String
    public let isDebug: Bool

    public init(base: String = "https://api.trakt.tv", apiVersion: String = "2", errorDomain: String = "com.svenbacia.traktkit", isDebug: Bool = false) {
        self.base = base
        self.apiVersion = apiVersion
        self.errorDomain = errorDomain
        self.isDebug = isDebug
    }
}
