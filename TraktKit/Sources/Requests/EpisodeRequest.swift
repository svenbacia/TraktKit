//
//  EpisodeRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public final class EpisodeRequest: Request {
    
    // MARK: - Properties
    
    private let show: Int
    private let season: Int
    private let episode: Int
    
    // MARK: - Init
    
    public init(show: Int, season: Int, episode: Int, trakt: Trakt) {
        self.show = show
        self.season = season
        self.episode = episode
        super.init(trakt: trakt)
    }
    
    // MARK: - Endpoints
    
    public func summary(extended: Extended? = nil, completion: @escaping CompletionHandler<Episode>) -> URLSessionTask? {
        let resource = EpisodeResource(show: show, season: season, episode: episode, configuration: trakt.configuration).summary(extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func comments(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[Comment]>) -> URLSessionTask? {
        let resource = EpisodeResource(show: show, season: season, episode: episode, configuration: trakt.configuration).comments(extended, page: page, limit: limit)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func ratings(_ completion: @escaping CompletionHandler<Ratings>) -> URLSessionTask? {
        let resource = EpisodeResource(show: show, season: season, episode: episode, configuration: trakt.configuration).ratings()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func stats(_ completion: @escaping CompletionHandler<Stats>) -> URLSessionTask? {
        let resource = EpisodeResource(show: show, season: season, episode: episode, configuration: trakt.configuration).stats()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func watching(extended: Extended? = nil, completion: @escaping CompletionHandler<[User]>) -> URLSessionTask? {
        let resource = EpisodeResource(show: show, season: season, episode: episode, configuration: trakt.configuration).watching(extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
}
