//
//  User.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct User {
  public let username: String
  public let isPrivate: Bool
  public let name: String?
  public let vip: Bool?
  public let vipEp: Bool?
  public let joinedAt: Date?
  public let location: String?
  public let about: String?
  public let gender: String?
  public let age: Int?
  public let avatar: Image?
}

extension User: Unboxable {
  public init(unboxer: Unboxer) {
    username  = unboxer.unbox(key: "username")
    isPrivate = unboxer.unbox(key: "private")
    name      = unboxer.unbox(key: "name")
    vip       = unboxer.unbox(key: "vip")
    vipEp     = unboxer.unbox(key: "vip_ep")
    joinedAt  = unboxer.unbox(key: "joined_at", formatter: DateFormatters.iso8601)
    location  = unboxer.unbox(key: "location")
    about     = unboxer.unbox(key: "about")
    gender    = unboxer.unbox(key: "gender")
    age       = unboxer.unbox(key: "age")
    avatar    = unboxer.unbox(key: "images.avatar", isKeyPath: true)
  }
}
