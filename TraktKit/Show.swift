//
//  Show.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Show {
  
  public enum Status: String, UnboxableEnum {
    case returningSeries = "returning series"
    case inProduction    = "in production"
    case planned         = "planned"
    case canceled        = "canceled"
    case ended           = "ended"
    
    public static func unboxFallbackValue() -> Status {
      return .returningSeries
    }
  }
  
  public struct Airs: Unboxable {
    public let day: String?
    public let time: String?
    public let timezone: String?
    
    public init(unboxer: Unboxer) {
      day      = unboxer.unbox(key: "day")
      time     = unboxer.unbox(key: "time")
      timezone = unboxer.unbox(key: "timezone")
    }
  }
  
  // MARK: - Properties
  
  public let id: Int
  public let slug: String?
  public let tvdb: Int?
  public let imdb: String?
  public let tmdb: Int?
  public let tvrage: Int?
  
  public let title: String
  public let year: Int?
  
  public let overview: String?
  public let firstAired: Date?
  
  public let runtime: Int?
  public let certification: String?
  public let network: String?
  public let country: String?
  public let trailer: URL?
  public let homepage: URL?
  public let status: Status?
  public let rating: Double?
  public let votes: Int?
  public let updatedAt: Date?
  public let language: String?
  public let availableTranslations: [String]?
  public let airedEpisodes: Int?
  public let genres: [String]?
  
  public let airs: Airs?
  public let fanart: Image?
  public let poster: Image?
  
}

extension Show: Unboxable {
  
  public init(unboxer: Unboxer) {
    id = unboxer.unbox(key: "ids.trakt", isKeyPath: true)
    slug = unboxer.unbox(key: "ids.slug", isKeyPath: true)
    tvdb = unboxer.unbox(key: "ids.tvdb", isKeyPath: true)
    imdb = unboxer.unbox(key: "ids.imdb", isKeyPath: true)
    tmdb = unboxer.unbox(key: "ids.tmdb", isKeyPath: true)
    tvrage = unboxer.unbox(key: "ids.tvrage", isKeyPath: true)
    
    title = unboxer.unbox(key: "title")
    year  = unboxer.unbox(key: "year")
    overview = unboxer.unbox(key: "overview")
    
    firstAired = unboxer.unbox(key: "first_aired", formatter: DateFormatters.iso8601)
    updatedAt = unboxer.unbox(key: "updated_at", formatter: DateFormatters.iso8601)
    
    runtime = unboxer.unbox(key: "runtime")
    certification = unboxer.unbox(key: "certification")
    network = unboxer.unbox(key: "network")
    country = unboxer.unbox(key: "country")
    trailer = unboxer.unbox(key: "trailer")
    homepage = unboxer.unbox(key: "homepage")
    status = unboxer.unbox(key: "status")
    rating = unboxer.unbox(key: "rating")
    votes = unboxer.unbox(key: "votes")
    language = unboxer.unbox(key: "language")
    availableTranslations = unboxer.unbox(key: "available_translations")
    airedEpisodes = unboxer.unbox(key: "aired_episodes")
    genres = unboxer.unbox(key: "genres")
    airs = unboxer.unbox(key: "airs")
    
    fanart = unboxer.unbox(key: "images.fanart", isKeyPath: true)
    poster = unboxer.unbox(key: "images.poster", isKeyPath: true)
  }
  
}
