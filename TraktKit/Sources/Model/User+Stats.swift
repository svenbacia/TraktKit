//
//  User+Stats.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension User {
    
    public struct Stats: Codable {
        
        // MARK: - Types
        
        public struct Movies: Codable {
            public let plays: Int
            public let minutes: Int
            public let collected: Int
            public let ratings: Int
            public let comments: Int
        }
        
        public struct Shows: Codable {
            public let watched: Int
            public let collected: Int
            public let ratings: Int
            public let comments: Int
        }
        
        public struct Seasons: Codable {
            public let ratings: Int
            public let comments: Int
        }
        
        public struct Episodes: Codable {
            public let plays: Int
            public let watched: Int
            public let minutes: Int
            public let collected: Int
            public let ratings: Int
            public let comments: Int
        }
        
        public struct Network: Codable {
            public let friends: Int
            public let followers: Int
            public let following: Int
        }
        
        public struct Ratings: Codable {
            public let total: Int
            public let distribution: [String: Int]
        }
        
        // MARK: - Properties
        
        public let movies: Movies
        public let shows: Shows
        public let seasons: Seasons
        public let episodes: Episodes
        public let network: Network
        public let ratings: Ratings
    }
}
