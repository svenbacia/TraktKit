//
//  CollectionListItem.swift
//  TraktKit
//
//  Created by Sven Bacia on 22.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct CollectionListItem: Codable {

    // MARK: - Types

    public struct Season: Codable {
        public let number: Int
        public let episodes: [Episode]
    }

    public struct Episode: Codable {

        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case number
            case collectedAt = "collected_at"
        }

        // MARK: - Properties

        public let number: Int
        public let collectedAt: Date
    }

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case lastCollectedAt = "last_collected_at"
        case show
        case seasons
    }

    // MARK: - Properties

    public let lastCollectedAt: Date
    public let show: Show
    public let seasons: [Season]
}
