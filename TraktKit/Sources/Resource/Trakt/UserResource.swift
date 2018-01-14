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

    public var lists: Resource<[List]> {
        return buildResource(base: configuration.base, path: "/users/\(user)/lists")
    }

    public func createList(name: String, description: String?, privacy: Privacy?, displayNumbers: Bool?, allowComments: Bool?) -> Resource<List> {
        var params: [String: Any] = [
            "name": name
        ]
        if let description = description {
            params["description"] = description
        }

        if let privacy = privacy {
            params["privacy"] = privacy.description
        }

        if let displayNumbers = displayNumbers {
            params["display_numbers"] = displayNumbers
        }

        if let allowComments = allowComments {
            params["allow_comments"] = allowComments
        }
        return buildResource(base: configuration.base, path: "/users/\(user)/lists", params: params, method: .post)
    }

    public func list(name: String) -> ListResource {
        return ListResource(list: name, username: user, configuration: configuration)
    }
}
