//
//  Explore.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Explore {
    
    // MARK: - TV Shows
    
    public struct Show {
        public static func trending(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: "/shows/trending", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func popular(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: "/shows/popular", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func anticipated(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: "/shows/anticipated", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func played(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: path("/shows/played", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func watched(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: path("/shows/watched", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func collected(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
            return resource(for: path("/shows/collected", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
    }
    
    // MARK: - Movies
   
    public struct Movie {
        public static func trending(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: "/movies/trending", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func popular(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: "/movies/popular", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func played(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: path("/movies/played", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func watched(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: path("/movies/watched", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func collected(period: Period? = nil, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: path("/movies/collected", with: period), params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func anticipated(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: "/movies/anticipated", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func boxoffice(extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: "/movies/boxoffice", params: parameters(page: page, limit: limit, extended: extended))
        }
        
        public static func updates(since date: Date, extended: Extended?, page: Int? = nil, limit: Int? = nil) -> Resource<Data> {
            return resource(for: "/movies/updates/\(Trakt.DateFormatter.movieUpdateDateFormatter.string(from: date))", params: parameters(page: page, limit: limit, extended: extended))
        }
    }
    
}
