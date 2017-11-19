//
//  ShowResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ShowResource {
    
    // MARK: - Properties
    
    private let id: Int
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(id: Int, configuration: Configuration) {
        self.id = id
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    
    public func summary(extended: Extended? = nil) -> Resource<Show> {
        return buildResource(base: configuration.base, path: "/shows/\(id)", params: parameters(extended: extended))
    }
    
    public func comments(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[Comment]> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/comments", params: parameters(page: page, limit: limit, extended: extended))
    }
    
    public func people(extended: Extended? = nil) -> Resource<Cast> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/people", params: parameters(extended: extended))
    }
    
    public func rating() -> Resource<Ratings> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/rating")
    }
    
    public func related(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[Show]> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/related", params: parameters(page: page, limit: limit, extended: extended))
    }
    
    public func stats() -> Resource<Stats> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/stats")
    }
    
    public func watching(extended: Extended? = nil) -> Resource<[User]> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/watching", params: parameters(extended: extended))
    }
    
    public func collectionProgress() -> Resource<Any> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/progress/collection")
    }
    
    public func watchedProgress() -> Resource<Any> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/progress/watched")
    }
    
    // MARK: - Seasons
    
    public func seasons(_ extended: Extended? = nil) -> Resource<[Season]> {
        return buildResource(base: configuration.base, path: "/shows/\(id)/seasons", params: parameters(extended: extended))
    }
    
    public func season(_ season: Int) -> SeasonResource {
        return SeasonResource(show: id, season: season, configuration: configuration)
    }
}
