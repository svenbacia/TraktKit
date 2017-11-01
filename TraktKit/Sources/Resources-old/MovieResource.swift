//
//  MovieRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 26.07.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct MovieResource {
    
    // MARK: - Properties
    
    private let id: Int
    
    // MARK: - Init
    
    public init(id: Int) {
        self.id = id
    }
    
    // MARK: - Endpoints
    
    /**
    public func summary(_ extended: Extended? = nil) -> Resource<Data> {
        return buildResource(path: "/movies/\(id)", params: parameters(extended: extended))
    }
    
    public func aliases() -> Resource<Any> {
        return buildResource(path: "/movies/\(id)/aliases")
    }
    
    public func releases(`for` country: String? = nil) -> Resource<Any> {
        var path = "/movies/\(id)/releases"
        if let country = country {
            path.append("/\(country)")
        }
        return buildResource(path: path)
    }
    
    public func translations(`for` country: String? = nil) -> Resource<Any> {
        var path = "/movies/\(id)/translations"
        if let country = country {
            path.append("/\(country)")
        }
        return buildResource(path: path)
    }
    
    public func comments(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
        return buildResource(path: "/movies/\(id)/comments", params: parameters(page: page, limit: limit, extended: extended))
    }
    
    public func people(_ extended: Extended? = nil) -> Resource<Data> {
        return buildResource(path: "/movies/\(id)/people", params: parameters(extended: extended))
    }
    
    public func ratings() -> Resource<Any> {
        return buildResource(path: "/movies/\(id)/rating")
    }
    
    public func related(_ extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
        return buildResource(path: "/movies/\(id)/related", params: parameters(page: page, limit: limit, extended: extended))
    }
    
    public func stats() -> Resource<Any> {
        return buildResource(path: "/movies/\(id)/stats")
    }
    
    public func watching(_ extended: Extended? = nil) -> Resource<Any> {
        return buildResource(path: "/movies/\(id)/watching", params: parameters(extended: extended))
    }
    
    public func collectionProgress() -> Resource<Any> {
        return buildResource(path: "/shows/\(id)/progress/collection")
    }
    
    public func watchedProgress() -> Resource<Any> {
        return buildResource(path: "/shows/\(id)/progress/watched")
    }
 */
}
