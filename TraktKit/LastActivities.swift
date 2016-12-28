//
//  LastActivities.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct LastActivities {
  
  public struct EpisodeActivities {
    let watchedAt: Date?
    let collectedAt: Date?
    let ratedAt: Date?
    let watchlistedAt: Date?
    let commentedAt: Date?
    let pausedAt: Date?
  }
  
  public struct ShowActivities {
    let ratedAt: Date?
    let watchlistedAt: Date?
    let commentedAt: Date?
    let hiddenAt: Date?
  }
  
  public struct SeasonActivities {
    let ratedAt: Date?
    let watchlistedAt: Date?
    let commentedAt: Date?
    let hiddenAt: Date?
  }
  
  public struct ListActivities {
    let likedAt: Date?
    let updatedAt: Date?
    let commentedAt: Date?
  }
  
  let all: Date?
  let episodes: EpisodeActivities
  let shows: ShowActivities
  let seasons: SeasonActivities
  let lists: ListActivities
  
}

extension LastActivities: Unboxable {
  public init(unboxer: Unboxer) {
    all = unboxer.unbox(key: "all", formatter: DateFormatters.iso8601)
    episodes = unboxer.unbox(key: "episodes")
    shows = unboxer.unbox(key: "shows")
    seasons = unboxer.unbox(key: "seasons")
    lists = unboxer.unbox(key: "lists")
  }
}

extension LastActivities.EpisodeActivities: Unboxable {
  public init(unboxer: Unboxer) {
    watchedAt = unboxer.unbox(key: "watched_at", formatter: DateFormatters.iso8601)
    collectedAt = unboxer.unbox(key: "collected_at", formatter: DateFormatters.iso8601)
    ratedAt = unboxer.unbox(key: "rated_at", formatter: DateFormatters.iso8601)
    watchlistedAt = unboxer.unbox(key: "watchlisted_at", formatter: DateFormatters.iso8601)
    commentedAt = unboxer.unbox(key: "commented_at", formatter: DateFormatters.iso8601)
    pausedAt = unboxer.unbox(key: "paused_at", formatter: DateFormatters.iso8601)
  }
}

extension LastActivities.ShowActivities: Unboxable {
  public init(unboxer: Unboxer) {
    ratedAt = unboxer.unbox(key: "rated_at", formatter: DateFormatters.iso8601)
    watchlistedAt = unboxer.unbox(key: "watchlisted_at", formatter: DateFormatters.iso8601)
    commentedAt = unboxer.unbox(key: "commented_at", formatter: DateFormatters.iso8601)
    hiddenAt = unboxer.unbox(key: "hidden_at", formatter: DateFormatters.iso8601)
  }
}

extension LastActivities.SeasonActivities: Unboxable {
  public init(unboxer: Unboxer) {
    ratedAt = unboxer.unbox(key: "rated_at", formatter: DateFormatters.iso8601)
    watchlistedAt = unboxer.unbox(key: "watchlisted_at", formatter: DateFormatters.iso8601)
    commentedAt = unboxer.unbox(key: "commented_at", formatter: DateFormatters.iso8601)
    hiddenAt = unboxer.unbox(key: "hidden_at", formatter: DateFormatters.iso8601)
  }
}

extension LastActivities.ListActivities: Unboxable {
  public init(unboxer: Unboxer) {
    commentedAt = unboxer.unbox(key: "commented_at", formatter: DateFormatters.iso8601)
    likedAt = unboxer.unbox(key: "liked_at", formatter: DateFormatters.iso8601)
    updatedAt = unboxer.unbox(key: "updated_at", formatter: DateFormatters.iso8601)
  }
}
