//
//  PeopleResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct PeopleResource {

    // MARK: - Init

    let configuration: Trakt.Configuration

    private let basePath: String

    // MARK: - Init

    init(id: Int, configuration: Trakt.Configuration) {
        self.basePath = "/people/\(id)"
        self.configuration = configuration
    }

    // MARK: - Endpoints

    public func summary(extended: Extended? = nil) -> Resource<Person> {
        return buildResource(base: configuration.base, path: basePath, params: parameters(extended: extended))
    }

    public func shows(extended: Extended? = nil) -> Resource<People.Shows> {
        return buildResource(base: configuration.base, path: basePath.appending("/shows"), params: parameters(extended: extended))
    }
}
