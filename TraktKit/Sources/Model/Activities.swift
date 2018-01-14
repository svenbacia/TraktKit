//
//  Activities.swift
//  TraktKit
//
//  Created by Sven Bacia on 22.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Activities: Codable {

    // MARK: - Types

    public struct Movies: Codable {
        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case watchedAt = "watched_at"
            case collectedAt = "collected_at"
            case ratedAt = "rated_at"
            case watchlistedAt = "watchlisted_at"
            case commentedAt = "commented_at"
            case pausedAt = "paused_at"
            case hiddenAt = "hidden_at"
        }

        // MARK: - Properties

        public let watchedAt: Date?
        public let collectedAt: Date?
        public let ratedAt: Date?
        public let watchlistedAt: Date?
        public let commentedAt: Date?
        public let pausedAt: Date?
        public let hiddenAt: Date?
    }

    public struct Episodes: Codable {
        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case watchedAt = "watched_at"
            case collectedAt = "collected_at"
            case ratedAt = "rated_at"
            case watchlistedAt = "watchlisted_at"
            case commentedAt = "commented_at"
            case pausedAt = "paused_at"
        }

        // MARK: - Properties

        public let watchedAt: Date?
        public let collectedAt: Date?
        public let ratedAt: Date?
        public let watchlistedAt: Date?
        public let commentedAt: Date?
        public let pausedAt: Date?
    }

    public struct Shows: Codable {
        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case ratedAt = "rated_at"
            case watchlistedAt = "watchlisted_at"
            case commentedAt = "commented_at"
            case hiddenAt = "hidden_at"
        }

        // MARK: - Properties

        public let ratedAt: Date?
        public let watchlistedAt: Date?
        public let commentedAt: Date?
        public let hiddenAt: Date?
    }

    public struct Seasons: Codable {
        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case ratedAt = "rated_at"
            case watchlistedAt = "watchlisted_at"
            case commentedAt = "commented_at"
            case hiddenAt = "hidden_at"
        }

        // MARK: - Properties

        public let ratedAt: Date?
        public let watchlistedAt: Date?
        public let commentedAt: Date?
        public let hiddenAt: Date?
    }

    public struct Comments: Codable {

        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case likedAt = "liked_at"
        }

        // MARK: - Properties

        public let likedAt: Date?
    }

    public struct Lists: Codable {
        // MARK: - Codable

        private enum CodingKeys: String, CodingKey {
            case likedAt = "liked_at"
            case updatedAt = "updated_at"
            case commentedAt = "commented_at"
        }

        // MARK: - Properties

        public let likedAt: Date?
        public let updatedAt: Date?
        public let commentedAt: Date?
    }

    // MARK: - Properties

    public let all: Date?
    public let movies: Movies
    public let episodes: Episodes
    public let shows: Shows
    public let seasons: Seasons
    public let comments: Comments
    public let lists: Lists
}
