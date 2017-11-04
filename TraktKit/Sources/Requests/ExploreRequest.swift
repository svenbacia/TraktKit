//
//  ExploreRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public final class ExploreRequest: Request {
    
    public var shows: ShowRequest {
        return ShowRequest(trakt: trakt)
    }
    
    /// Explore tv show endpoints
    public final class ShowRequest: Request {
        
        public func trending(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[TrendingShow]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.trending(extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
        
        public func popular(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[Show]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.popular(extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
        
        public func anticipated(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[AnticipatedShow]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.anticipated(extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
        
        public func played(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[PlayedShow]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.played(period: period, extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
        
        public func watched(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[WatchedShow]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.watched(period: period, extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
        
        public func collected(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[CollectedShow]>) -> URLSessionTask? {
            let resource = ExploreResource(configuration: trakt.configuration).shows.collected(period: period, extended: extended, page: page, limit: limit)
            return trakt.load(resource: resource, authenticated: false, completion: completion)
        }
    }
    
    /// Explore movie endpoints
    public final class Movie: Request {
        
    }
}
