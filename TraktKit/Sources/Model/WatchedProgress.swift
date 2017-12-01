//
//  WatchedProgress.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct WatchedProgress: Codable {
    
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
            case completed
            case lastWatchedAt = "last_watched_at"
        }
        public let number: Int
        public let completed: Bool
        public let lastWatchedAt: Date?
    }
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case aired
        case completed
        case lastWatchedAt = "last_watched_at"
        case seasons
        case hiddenSeasons = "hidden_seasons"
        case nextEpisode = "next_episode"
        case lastEpisode = "last_episode"
    }
    
    // MARK: - Properties
    
    public let aired: Int
    public let completed: Int
    public let lastWatchedAt: Date?
    public let seasons: [Season]
    public let hiddenSeasons: [Season]
    public let nextEpisode: TraktKit.Episode?
    public let lastEpisode: TraktKit.Episode?
}
