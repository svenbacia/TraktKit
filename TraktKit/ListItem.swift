//
//  ListItem.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum ListItemType: String, UnboxableEnum {
  case show
  case season
  case episode
  case people
  
  public static func unboxFallbackValue() -> ListItemType {
    return .show
  }
}

public struct ListItem<T: Unboxable> {
  public let rank: Int
  public let listedAt: Date
  public let type: ListItemType
  public let item: T
}

extension ListItem: Unboxable {
  public init(unboxer: Unboxer) {
    rank     = unboxer.unbox(key: "rank")
    listedAt = unboxer.unbox(key: "listed_at", formatter: DateFormatters.iso8601)
    type     = unboxer.unbox(key: "type")
    item     = unboxer.unbox(key: type.rawValue)
  }
}

