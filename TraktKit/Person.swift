//
//  Person.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Person {
  public let name: String
  public let id: Int
  public let slug: String
  public let imdb: String?
  public let tmdb: Int?
  public let tvrage: Int?
  public let biography: String?
  public let birthday: Date?
  public let death: Date?
  public let birthplace: String?
  public let homepage: URL?
  public let headshot: Image?
  public let fanart: Image?
}

extension Person: Unboxable {
  public init(unboxer: Unboxer) {
    name       = unboxer.unbox(key: "name")
    id         = unboxer.unbox(key: "ids.trakt", isKeyPath: true)
    slug       = unboxer.unbox(key: "ids.slug", isKeyPath: true)
    imdb       = unboxer.unbox(key: "ids.imdb", isKeyPath: true)
    tmdb       = unboxer.unbox(key: "ids.tmdb", isKeyPath: true)
    tvrage     = unboxer.unbox(key: "ids.tvrage", isKeyPath: true)
    biography  = unboxer.unbox(key: "biography")
    birthday   = unboxer.unbox(key: "birthday", formatter: DateFormatters.person)
    death      = unboxer.unbox(key: "death", formatter: DateFormatters.person)
    birthplace = unboxer.unbox(key: "birthplace")
    homepage   = unboxer.unbox(key: "homepage")
    headshot   = unboxer.unbox(key: "images.headshot", isKeyPath: true)
    fanart     = unboxer.unbox(key: "images.fanart", isKeyPath: true)
  }
}

extension Person: KeyType {
  public static var key: String {
    return "person"
  }
}
