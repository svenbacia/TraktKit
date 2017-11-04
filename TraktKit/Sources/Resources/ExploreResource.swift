//
//  Explore.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct ExploreResource {
    
    // MARK: - Properties
    
    private let configuration: Configuration
    
    // MARK: - Init
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    // MARK: - Access
    
    public var shows: ShowResource {
        return ShowResource(configuration: configuration)
    }
    
    public var movies: MovieResource {
        return MovieResource()
    }
    
    // MARK: - TV Shows
    
    public struct ShowResource {
        
        private let configuration: Configuration
        
        init(configuration: Configuration) {
            self.configuration = configuration
        }
        
        public func trending(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[TrendingShow]> {
            return buildResource(base: configuration.base, path: "/shows/trending", params: parameters(page: page, limit: limit, extended: extended))
        }

        public func popular(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[Show]> {
            return buildResource(base: configuration.base, path: "/shows/popular", params: parameters(page: page, limit: limit, extended: extended))
        }

        public func anticipated(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[AnticipatedShow]> {
            return buildResource(base: configuration.base, path: "/shows/anticipated", params: parameters(page: page, limit: limit, extended: extended))
        }

        public func played(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[PlayedShow]> {
            return buildResource(base: configuration.base, path: path("/shows/played", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }

        public func watched(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[WatchedShow]> {
            return buildResource(base: configuration.base, path: path("/shows/watched", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }

        public func collected(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<[CollectedShow]> {
            return buildResource(base: configuration.base, path: path("/shows/collected", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
    }
    
    // MARK: - Movies
   
    public struct MovieResource {
//        public func trending(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: "/movies/trending", params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func popular(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: "/movies/popular", params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func played(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: path("/movies/played", with: period), params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func watched(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: path("/movies/watched", with: period), params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func collected(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: path("/movies/collected", with: period), params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func anticipated(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: "/movies/anticipated", params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func boxoffice(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: "/movies/boxoffice", params: parameters(page: page, limit: limit, extended: extended))
//        }
//        
//        public func updates(since date: Date, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
//            return buildResource(path: "/movies/updates/\(Trakt.DateFormatter.movieUpdateDateFormatter.string(from: date))", params: parameters(page: page, limit: limit, extended: extended))
//        }
    }
    
}
