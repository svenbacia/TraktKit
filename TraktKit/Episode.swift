//
//  Episode.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Episode {
  public let season: Int
  public let number: Int
  public let title: String?
  public let id: Int
  public let tvdb: Int?
  public let imdb: String?
  public let tmdb: Int?
  public let tvrage: Int?
  public let overview: String?
  public let rating: Double?
  public let votes: Int?
  public let firstAired: Date?
  public let updateAt: Date?
  public let availableTranslations: [String]?
  public let screenshot: Image?
}

extension Episode: Unboxable {
  public init(unboxer: Unboxer) {
    season     = unboxer.unbox(key: "season")
    number     = unboxer.unbox(key: "number")
    title      = unboxer.unbox(key: "title")
    id         = unboxer.unbox(key: "ids.trakt", isKeyPath: true)
    tvdb       = unboxer.unbox(key: "ids.tvdb", isKeyPath: true)
    imdb       = unboxer.unbox(key: "ids.tvdb", isKeyPath: true)
    tmdb       = unboxer.unbox(key: "ids.tmdb", isKeyPath: true)
    tvrage     = unboxer.unbox(key: "ids.tvrage", isKeyPath: true)
    overview   = unboxer.unbox(key: "overview")
    rating     = unboxer.unbox(key: "rating")
    votes      = unboxer.unbox(key: "votes")
    firstAired = unboxer.unbox(key: "first_aired", formatter: DateFormatters.ios8601)
    updateAt   = unboxer.unbox(key: "updated_at", formatter: DateFormatters.ios8601)
    availableTranslations = unboxer.unbox(key: "available_translations")
    screenshot = unboxer.unbox(key: "images.screenshot")
  }
}
