//
//  EpisodeResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct EpisodeResource {

    // MARK: - Properties

    private let basePath: String
    private let configuration: Trakt.Configuration

    // MARK: - Init

    init(show: Int, season: Int, episode: Int, configuration: Trakt.Configuration) {
        self.basePath = "/shows/\(show)/seasons/\(season)/episodes/\(episode)"
        self.configuration = configuration
    }

    // MARK: - Endpoints

    public func summary(_ extended: Extended? = nil) -> Resource<Episode> {
        return buildResource(base: configuration.base, path: basePath, params: parameters(extended: extended))
    }

    public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[Comment]> {
        return buildResource(base: configuration.base, path: basePath + "/comments", params: parameters(page: page, limit: limit, extended: extended))
    }

    public func ratings() -> Resource<Ratings> {
        return buildResource(base: configuration.base, path: basePath + "/ratings")
    }

    public func stats() -> Resource<Stats> {
        return buildResource(base: configuration.base, path: basePath + "/stats")
    }

    public func watching(_ extended: Extended? = nil) -> Resource<[User]> {
        return buildResource(base: configuration.base, path: basePath + "/watching", params: parameters(extended: extended))
    }
}
