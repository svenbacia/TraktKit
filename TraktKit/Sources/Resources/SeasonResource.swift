//
//  SeasonRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct SeasonResource {
    
    // MARK: - Properties
    
    private let show: Int
    private let season: Int
    private let basePath: String
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(show: Int, season: Int, configuration: Configuration) {
        self.show = show
        self.season = season
        self.basePath = "/shows/\(show)/seasons/\(season)"
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    
    public func summary(extended: Extended? = nil) -> Resource<Season> {
        return buildResource(base: configuration.base, path: basePath, params: parameters(extended: extended))
    }
    
    public func comments(page: Int? = nil, limit: Int? = nil) -> Resource<[Comment]> {
        return buildResource(base: configuration.base, path: basePath + "/comments", params: parameters(page: page, limit: limit))
    }
    
    public func ratings() -> Resource<Ratings> {
        return buildResource(base: configuration.base, path: basePath + "/ratings")
    }
    
    public func stats() -> Resource<Stats> {
        return buildResource(base: configuration.base, path: basePath + "/stats")
    }
    
    public func watching(extended: Extended? = nil) -> Resource<[User]> {
        return buildResource(base: configuration.base, path: basePath + "/watching", params: parameters(extended: extended))
    }
}
