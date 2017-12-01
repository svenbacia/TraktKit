//
//  UserResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct UserResource {
    
    // MARK: - Properties
    
    private let user: String
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(user: String, configuration: Configuration) {
        self.user = user
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    
    public func profile(extended: Extended? = nil) -> Resource<User> {
        return buildResource(base: configuration.base, path: "/users/\(user)", params: parameters(extended: extended))
    }
    
    public var stats: Resource<User.Stats> {
        return buildResource(base: configuration.base, path: "/users/\(user)/stats")
    }
    
    public func lists() -> Resource<Any> {
        return buildResource(base: configuration.base, path: "/users/\(user)/lists")
    }
}
