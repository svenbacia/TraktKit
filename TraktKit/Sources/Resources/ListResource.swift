//
//  ListResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct ListResource {
    
    // MARK: - Properties
    
    private let username: String
    private let list: String
    private let path: String
    
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(list: String, username: String, configuration: Configuration) {
        self.username = username
        self.list = list
        self.path = "/users/\(username)/lists/\(list)"
        self.configuration = configuration
    }
    
    // MARK: - Endpoints
    
    public var summary: Resource<List> {
        return buildResource(base: configuration.base, path: path)
    }
    
    public func items(type: ListItemType? = nil, extended: Extended? = nil) -> Resource<[ListItem]> {
        return buildResource(base: configuration.base, path: buildPath(path, type: type), params: parameters(extended: extended))
    }
    
    public func add(items: [ContentItem]) -> Resource<Any> {
        let container = ContentItemContainer(items: items)
        return buildResource(base: configuration.base, path: path.appending("/items"), params: container.asJSON, method: .post)
    }
    
    public func remove(items: [ContentItem]) -> Resource<Any> {
        let container = ContentItemContainer(items: items)
        return buildResource(base: configuration.base, path: path.appending("/items/remove"), params: container.asJSON, method: .post)
    }
}
