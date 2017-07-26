//
//  TraktExplore.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
    
    // MARK: - TV Shows
    
    public func trendingShows(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.trending(extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    public func popularShows(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.popular(extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    public func anticipatedShows(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.anticipated(extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    public func playedShows(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.played(period: period, extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    public func watchedShows(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.watched(period: period, extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    public func collectedShows(period: Period? = nil, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Show.collected(period: period, extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
    // MARK: - Movies
    
    public func trendingMovie(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Any, TraktError>) -> Void) -> URLSessionTask? {
        return load(resource: Explore.Movie.trending(extended: extended, page: page, limit: limit),
                    authenticated: false,
                    completion: completion)
    }
    
}
