//
//  WatchedList.swift
//  TraktKit
//
//  Created by Sven Bacia on 22.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct WatchedListItem: Codable {

    // MARK: - Types

    public struct Season: Codable {
        public let number: Int
        public let episodes: [Episode]
    }

    public struct Episode: Codable {

        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case number
            case plays
            case lastWatchedAt = "last_watched_at"
        }

        // MARK: - Properties

        public let number: Int
        public let plays: Int
        public let lastWatchedAt: Date
    }

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case plays
        case lastWatchedAt = "last_watched_at"
        case show
        case seasons
    }

    // MARK: - Properties

    public let plays: Int
    public let lastWatchedAt: Date
    public let show: Show
    public let seasons: [Season]
}
