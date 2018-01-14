//
//  Resources.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Resources {

    // MARK: - Properties

    private let configuration: Configuration
    private let credentials: Credentials

    // MARK: - Init

    init(configuration: Configuration, credentials: Credentials) {
        self.configuration = configuration
        self.credentials = credentials
    }

    // MARK: - Endpoints

    public var explore: ExploreResource {
        return ExploreResource(configuration: configuration)
    }

    public func show(_ id: Int) -> ShowResource {
        return ShowResource(id: id, configuration: configuration)
    }

    public func people(_ id: Int) -> PeopleResource {
        return PeopleResource(id: id, configuration: configuration)
    }

    public func user(_ username: String) -> UserResource {
        return UserResource(user: username, configuration: configuration)
    }

    public var search: SearchResource {
        return SearchResource(configuration: configuration)
    }

    public var sync: SyncResource {
        return SyncResource(configuration: configuration)
    }
}
