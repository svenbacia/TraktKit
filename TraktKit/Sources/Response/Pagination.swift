//
//  Pagination.swift
//  TraktKit
//
//  Created by Sven Bacia on 07.09.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Pagination {
    public let page: Int
    public let limit: Int
    public let numberOfPages: Int
    public let numberOfItems: Int

    public init?(headers: [String: Any]) {
        guard let pageString = headers["x-pagination-page"] as? String, let page = Int(pageString) else { return nil }
        guard let limitString = headers["x-pagination-limit"] as? String, let limit = Int(limitString) else { return nil }
        guard let numberOfPagesString = headers["x-pagination-page-count"] as? String, let numberOfPages = Int(numberOfPagesString) else { return nil }
        guard let numberOfItemsString = headers["x-pagination-item-count"] as? String, let numberOfItems = Int(numberOfItemsString) else { return nil }
        self.page = page
        self.limit = limit
        self.numberOfPages = numberOfPages
        self.numberOfItems = numberOfItems
    }
}
