//
//  Stats.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Stats {
  public let watchers: Int
  public let plays: Int
  public let collectors: Int
  public let comments: Int
  public let lists: Int
  public let votes: Int
  public let collectedEpisodes: Int?
}

extension Stats: Unboxable {
  public init(unboxer: Unboxer) {
    watchers          = unboxer.unbox(key: "watchers")
    plays             = unboxer.unbox(key: "plays")
    collectors        = unboxer.unbox(key: "collectors")
    collectedEpisodes = unboxer.unbox(key: "collected_episodes")
    comments          = unboxer.unbox(key: "comments")
    lists             = unboxer.unbox(key: "lists")
    votes             = unboxer.unbox(key: "votes")
  }
}
