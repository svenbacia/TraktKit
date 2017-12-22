//
//  SyncResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 22.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct SyncResource {
    
    // MARK: - Properties
    
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    
    public func lastActivities() -> Resource<Activities> {
        return buildResource(base: configuration.base, path: "/sync/last_activities")
    }
    
    public func collection(_ extended: Extended? = nil) -> Resource<[CollectionListItem]> {
        return buildResource(base: configuration.base, path: "/sync/collection/shows", params: parameters(extended: extended))
    }
    
    public func watched(_ extended: Extended? = nil) -> Resource<[WatchedListItem]> {
        return buildResource(base: configuration.base, path: "/sync/watched/shows", params: parameters(extended: extended))
    }
    
    public func watchlist(_ extended: Extended? = nil) -> Resource<[ListItem]> {
        return buildResource(base: configuration.base, path: "/sync/watchlist/shows", params: parameters(extended: extended))
    }
    
    // MARK: History
    
    public func addToHistory(_ items: [ContentItem]) -> Resource<Any> {
        let container = ContentItemContainer(items: items)
        return buildResource(base: configuration.base, path: "/sync/history", params: container.asJSON, method: .post)
    }
    
    public func removeFromHistory(_ items: [ContentItem]) -> Resource<Any> {
        let container = ContentItemContainer(items: items)
        return buildResource(base: configuration.base, path: "/sync/history/remove", params: container.asJSON, method: .post)
    }
}
