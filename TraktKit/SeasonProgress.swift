//
//  SeasonProgress.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public protocol SeasonProgress {
  
  associatedtype EpisodeProgress
  
  var number: Int { get }
  var aired: Int { get }
  var completed: Int { get }
  var episodes: [EpisodeProgress] { get }
}

// MARK: - Watched Progress

public struct SeasonWatchedProgress: SeasonProgress {
  public let number: Int
  public let aired: Int
  public let completed: Int
  public let episodes: [EpisodeWatchedProgress]
}

extension SeasonWatchedProgress: Unboxable {
  public init(unboxer: Unboxer) {
    number    = unboxer.unbox(key: "number")
    aired     = unboxer.unbox(key: "aired")
    completed = unboxer.unbox(key: "completed")
    episodes  = unboxer.unbox(key: "episodes")
  }
}

// MARK: - Collection Progress

public struct SeasonCollectionProgress: SeasonProgress {
  public let number: Int
  public let aired: Int
  public let completed: Int
  public let episodes: [EpisodeCollectionProgress]
}

extension SeasonCollectionProgress: Unboxable {
  public init(unboxer: Unboxer) {
    number    = unboxer.unbox(key: "number")
    aired     = unboxer.unbox(key: "aired")
    completed = unboxer.unbox(key: "completed")
    episodes  = unboxer.unbox(key: "episodes")
  }
}
