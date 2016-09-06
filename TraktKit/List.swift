//
//  List.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum Privacy: String, CustomStringConvertible {
  case `private`
  case friends
  case `public`
  
  public var description: String {
    return self.rawValue.lowercased()
  }
}

extension Privacy: UnboxableEnum {
  public static func unboxFallbackValue() -> Privacy {
    return .private
  }
}

public struct List {
  public let id: Int
  public let slug: String
  public let name: String
  public let description: String?
  public let privacy: Privacy
  public let displayNumbers: Bool
  public let allowComments: Bool
  public let sortBy: String
  public let sortHow: String
  public let createdAt: Date
  public let updatedAt: Date
  public let itemCount: Int
  public let commentCount: Int
  public let likes: Int
  public let user: User
}

extension List: Unboxable {
  public init(unboxer: Unboxer) {
    id             = unboxer.unbox(key: "ids.trakt", isKeyPath: true)
    slug           = unboxer.unbox(key: "ids.slug", isKeyPath: true)
    name           = unboxer.unbox(key: "name")
    description    = unboxer.unbox(key: "description")
    privacy        = unboxer.unbox(key: "privacy")
    displayNumbers = unboxer.unbox(key: "display_numbers")
    allowComments  = unboxer.unbox(key: "allow_comments")
    sortBy         = unboxer.unbox(key: "name")
    sortHow        = unboxer.unbox(key: "name")
    createdAt      = unboxer.unbox(key: "created_at", formatter: DateFormatters.iso8601)
    updatedAt      = unboxer.unbox(key: "updated_at", formatter: DateFormatters.iso8601)
    user           = unboxer.unbox(key: "user")
    itemCount      = unboxer.unbox(key: "item_count")
    commentCount   = unboxer.unbox(key: "comment_count")
    likes          = unboxer.unbox(key: "likes")
  }
}
