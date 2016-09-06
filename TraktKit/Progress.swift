//
//  Progress.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public protocol Progress {
  
  associatedtype SeasonProgress
  
  var aired: Int { get }
  var completed: Int { get }
  var date: Date? { get }
  var seasons: [SeasonProgress] { get }
  var nextEpisode: Episode? { get }
}

// MARK: - Watched Progress

public struct WatchedProgress: Progress {
  public let aired: Int
  public let completed: Int
  public let date: Date?
  public let seasons: [SeasonWatchedProgress]
  public let nextEpisode: Episode?
}

extension WatchedProgress: Unboxable {
  public init(unboxer: Unboxer) {
    aired       = unboxer.unbox(key: "aired")
    completed   = unboxer.unbox(key: "completed")
    date        = unboxer.unbox(key: "last_watched_at", formatter: DateFormatters.ios8601)
    seasons     = unboxer.unbox(key: "seasons")
    nextEpisode = unboxer.unbox(key: "next_episode")
  }
}

// MARK: - Collection Progress

public struct CollectionProgress: Progress {
  public let aired: Int
  public let completed: Int
  public let date: Date?
  public let seasons: [SeasonCollectionProgress]
  public let nextEpisode: Episode?
}

extension CollectionProgress: Unboxable {
  public init(unboxer: Unboxer) {
    aired       = unboxer.unbox(key: "aired")
    completed   = unboxer.unbox(key: "completed")
    date        = unboxer.unbox(key: "last_collected_at", formatter: DateFormatters.ios8601)
    seasons     = unboxer.unbox(key: "seasons")
    nextEpisode = unboxer.unbox(key: "next_episode")
  }
}
