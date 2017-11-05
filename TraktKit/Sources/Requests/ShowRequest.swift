//
//  ShowRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public final class ShowRequest: Request {
    
    // MARK: - Properties
    
    private let id: Int
    
    // MARK: - Init
    
    public init(id: Int, trakt: Trakt) {
        self.id = id
        super.init(trakt: trakt)
    }
    
    // MARK: - Show Endpoints
    
    public func summary(extended: Extended? = nil, completion: @escaping CompletionHandler<Show>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).summary(extended: extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func comments(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[Comment]>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).comments(extended: extended, page: page, limit: limit)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func people(extended: Extended? = nil, completion: @escaping CompletionHandler<Cast>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).people(extended: extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func rating(_ completion: @escaping CompletionHandler<Ratings>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).rating()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func related(extended: Extended? = nil, page: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler<[Show]>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).related(extended: extended, page: page, limit: limit)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func stats(_ completion: @escaping CompletionHandler<Stats>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).stats()
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func watching(extended: Extended? = nil, completion: @escaping CompletionHandler<[User]>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).watching(extended: extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    // MARK: - Season Endpoints
    
    public func seasons(extended: Extended? = nil, completion: @escaping CompletionHandler<[Season]>) -> URLSessionTask? {
        let resource = ShowResource(id: id, configuration: trakt.configuration).seasons(extended)
        return trakt.load(resource: resource, authenticated: false, completion: completion)
    }
    
    public func season(_ number: Int) -> SeasonRequest {
        return SeasonRequest(show: id, season: number, trakt: trakt)
    }
}
