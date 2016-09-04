//
//  TrendingShow.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct TrendingShow {
  public let show: Show
  public let watchers: Int
}

// MARK: - CustomStringConvertible

extension TrendingShow: CustomStringConvertible {
  public var description: String {
    return "\(watchers) watching \(show)"
  }
}

// MARK: - Unboxable

extension TrendingShow: Unboxable {
  public init(unboxer: Unboxer) {
    show = unboxer.unbox(key: "show")
    watchers = unboxer.unbox(key: "watchers")
  }
}
