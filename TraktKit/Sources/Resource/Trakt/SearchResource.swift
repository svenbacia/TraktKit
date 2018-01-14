//
//  SearchResource.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct SearchResource {

    // MARK: - Properties

    private let configuration: Configuration

    // MARK: - Init

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    // MARK: - Endpoints

    public func `for`(_ title: String, ofType searchType: SearchType, extended: Extended? = nil, page: Int? = nil, limit: Int? = nil) -> Resource<[SearchItem]> {
        return buildResource(base: configuration.base, path: "/search/\(searchType.rawValue)", params: parameters(with: ["query": title], page: page, limit: limit, extended: extended), method: .get)
    }
}
