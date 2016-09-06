//
//  EpisodeProgress.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public protocol EpisodeProgress {
  var number: Int { get }
  var completed: Bool { get }
  var date: Date? { get }
}

// MARK: - Watched Progress

public struct EpisodeCollectionProgress: EpisodeProgress {
  public let number: Int
  public let completed: Bool
  public let date: Date?
}

extension EpisodeCollectionProgress: Unboxable {
  public init(unboxer: Unboxer) {
    number    = unboxer.unbox(key: "number")
    completed = unboxer.unbox(key: "completed")
    date      = unboxer.unbox(key: "collected_at", formatter: DateFormatters.iso8601)
  }
}

// MARK: - Collection Progress

public struct EpisodeWatchedProgress: EpisodeProgress {
  public let number: Int
  public let completed: Bool
  public let date: Date?
}

extension EpisodeWatchedProgress: Unboxable {
  public init(unboxer: Unboxer) {
    number    = unboxer.unbox(key: "number")
    completed = unboxer.unbox(key: "completed")
    date      = unboxer.unbox(key: "last_watched_at", formatter: DateFormatters.iso8601)
  }
}
