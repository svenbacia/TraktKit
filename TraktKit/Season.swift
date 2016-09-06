//
//  Season.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Season {
  public let number: Int
  public let id: Int
  public let tvdb: Int?
  public let tmdb: Int?
  public let tvrage: Int?
  public let rating: Double?
  public let votes: Int?
  public let episodeCount: Int?
  public let airedEpisodes: Int?
  public let overview: String?
  public let firstAired: Date?
  public let poster: Image?
  public let thumb: Image?
  public let episodes: [Episode]?
}

extension Season: Unboxable {
  public init(unboxer: Unboxer) {
    number        = unboxer.unbox(key: "number")
    id            = unboxer.unbox(key: "ids.trakt", isKeyPath: true)
    tvdb          = unboxer.unbox(key: "ids.tvdb", isKeyPath: true)
    tmdb          = unboxer.unbox(key: "ids.tmdb", isKeyPath: true)
    tvrage        = unboxer.unbox(key: "ids.tvrage", isKeyPath: true)
    rating        = unboxer.unbox(key: "rating")
    votes         = unboxer.unbox(key: "votes")
    episodeCount  = unboxer.unbox(key: "episode_count")
    airedEpisodes = unboxer.unbox(key: "aired_episodes")
    overview      = unboxer.unbox(key: "overview")
    firstAired    = unboxer.unbox(key: "first_aired", formatter: DateFormatters.iso8601)
    poster        = unboxer.unbox(key: "images.poster", isKeyPath: true)
    thumb         = unboxer.unbox(key: "images.thumb", isKeyPath: true)
    episodes      = unboxer.unbox(key: "episodes")
  }
}
