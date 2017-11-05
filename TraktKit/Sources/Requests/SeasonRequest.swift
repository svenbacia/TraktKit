//
//  SeasonRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public final class SeasonRequest: Request {
    
    // MARK: - Properties
    
    private let show: Int
    private let season: Int
    
    // MARK: - Init
    
    public init(show: Int, season: Int, trakt: Trakt) {
        self.show = show
        self.season = season
        super.init(trakt: trakt)
    }
    
    // MARK: - Endpoints
    
    public func summary(extended: Extended? = nil, completion: @escaping CompletionHandler<Season>) -> URLSessionTask? {
        let resource = SeasonResource(show: show, season: season, configuration: trakt.configuration).summary(extended: extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func comments(page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[Comment]>) -> URLSessionTask? {
        let resource = SeasonResource(show: show, season: season, configuration: trakt.configuration).comments(page: page, limit: limit)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func ratings(_ completion: @escaping CompletionHandler<Ratings>) -> URLSessionTask? {
        let resource = SeasonResource(show: show, season: season, configuration: trakt.configuration).ratings()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func stats(_ completion: @escaping CompletionHandler<Stats>) -> URLSessionTask? {
        let resource = SeasonResource(show: show, season: season, configuration: trakt.configuration).stats()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func watching(extended: Extended? = nil, completion: @escaping CompletionHandler<[User]>) -> URLSessionTask? {
        let resource = SeasonResource(show: show, season: season, configuration: trakt.configuration).watching(extended: extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    // MARK: - Episode Endpoints
    
    public func episode(_ number: Int) -> EpisodeRequest {
        return EpisodeRequest(show: show, season: season, episode: number, trakt: trakt)
    }
}
