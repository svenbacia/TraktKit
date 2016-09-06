//
//  Comment.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Comment {
  public let id: Int
  public let comment: String
  public let spoiler: Bool
  public let review: Bool
  public let createdAt: Date
  public let updatedAt: Date
  public let replies: Int
  public let likes: Int
  public let userRating: Int?
  public let user: User
  public let parentId: Int?
}

extension Comment: Unboxable {
  public init(unboxer: Unboxer) {
    id         = unboxer.unbox(key: "id")
    comment    = unboxer.unbox(key: "comment")
    spoiler    = unboxer.unbox(key: "spoiler")
    review     = unboxer.unbox(key: "review")
    createdAt  = unboxer.unbox(key: "created_at", formatter: DateFormatters.ios8601)
    updatedAt  = unboxer.unbox(key: "updated_at", formatter: DateFormatters.ios8601)
    replies    = unboxer.unbox(key: "replies")
    likes      = unboxer.unbox(key: "likes")
    userRating = unboxer.unbox(key: "user_rating")
    parentId   = unboxer.unbox(key: "parent_id")
    user       = unboxer.unbox(key: "user")
  }
}
