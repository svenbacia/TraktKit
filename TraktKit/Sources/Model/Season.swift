//
//  Season.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Season: Codable {

    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case number
        case ids
        case rating
        case votes
        case episodesCount = "episode_count"
        case airedEpisodes = "aired_episodes"
        case title
        case overview
        case firstAired = "first_aired"
        case network
        case episodes
    }

    // MARK: - Properties

    public let number: Int
    public let ids: Ids
    public let rating: Double
    public let votes: Int
    public let episodesCount: Int
    public let airedEpisodes: Int
    public let title: String?
    public let overview: String?
    public let firstAired: Date?
    public let network: String?
    public let episodes: [Episode]?

    // MARK: - Init

    public init(number: Int, ids: Ids, rating: Double, votes: Int, episodesCount: Int, airedEpisodes: Int, title: String?, overview: String?, firstAired: Date?, network: String?, episodes: [Episode]?) { //swiftlint:disable:this line_length
        self.number = number
        self.ids = ids
        self.rating = rating
        self.votes = votes
        self.episodesCount = episodesCount
        self.airedEpisodes = airedEpisodes
        self.title = title
        self.overview = overview
        self.firstAired = firstAired
        self.network = network
        self.episodes = episodes
    }
}
