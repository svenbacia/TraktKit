//
//  Stats.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Stats: Codable {

    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case watchers
        case plays
        case collectors
        case collectedEpisodes = "collected_episodes"
        case comments
        case lists
        case votes
    }

    // MARK: - Properties

    public let watchers: Int
    public let plays: Int
    public let collectors: Int
    public let collectedEpisodes: Int?
    public let comments: Int
    public let lists: Int
    public let votes: Int
}
