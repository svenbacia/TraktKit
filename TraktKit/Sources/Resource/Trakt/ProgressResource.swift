//
//  ProgressResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct ProgressResource {

    // MARK: - Properties

    private let show: Int
    private let configuration: Configuration

    // MARK: - Init

    init(show: Int, configuration: Configuration) {
        self.show = show
        self.configuration = configuration
    }

    // MARK: - Endpoints

    public func collection() -> Resource<CollectionProgress> {
        return buildResource(base: configuration.base, path: "/shows/\(show)/progress/collection")
    }

    public func watched() -> Resource<WatchedProgress> {
        return buildResource(base: configuration.base, path: "/shows/\(show)/progress/watched")
    }
}
