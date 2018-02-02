//
//  CollectionProgress.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct CollectionProgress: Codable {

    // MARK: - Types

    public struct Season: Codable {
        public let number: Int
        public let aired: Int
        public let completed: Int
        public let episodes: [Episode]
    }

    public struct Episode: Codable {
        private enum CodingKeys: String, CodingKey {
            case number
            case isCompleted = "completed"
            case collectedAt = "collected_at"
        }
        public let number: Int
        public let isCompleted: Bool
        public let collectedAt: Date?
    }

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case aired
        case completed
        case lastCollectedAt = "last_collected_at"
        case seasons
        case hiddenSeasons = "hidden_seasons"
        case nextEpisode = "next_episode"
        case lastEpisode = "last_epispde"
    }

    // MARK: - Properties

    public let aired: Int
    public let completed: Int
    public let lastCollectedAt: Date?
    public let seasons: [Season]
    public let hiddenSeasons: [Season]
    public let nextEpisode: TraktKit.Episode?
    public let lastEpisode: TraktKit.Episode?
}
