//
//  Extended.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

/**
 *  By default, all methods will return minimal info for movies, shows, episodes, people, and users.
 *  Minimal info is typiclly all you need to match locally cached items and includes the title, year, and ids.
 *  However, you can request different extended levels of information by adding more extended information to a request.
 */
public struct Extended: OptionSet, CustomStringConvertible {

  // MARK: - Private Extended Type

  private enum ExtendedType: Int, CustomStringConvertible {
    case min = 1
    case images = 2
    case full = 4
    case episodes = 8

    static var allTypes: [ExtendedType] {
      return [.min, .images, .full, .episodes]
    }

    var description: String {
      switch self {
      case .min:
        return "min"
      case .images:
        return "images"
      case .full:
        return "full"
      case .episodes:
        return "episodes"
      }
    }
  }

  // MARK: - Options

  /// Default Returns enough info to match locally.
  public static let min = Extended(.min)

  /// Minimal info and all images.
  public static let images = Extended(.images)

  /// Complete info for an item.
  public static let full = Extended(.full)

  /// **Season Summary Only**: Returns all episodes for all seasons.
  /// **Note**: This returns a lot of data, so please only use this method if you need it all!
  public static let episodes = Extended(.episodes)

  // MARK: - Properties

  public let rawValue: Int

  // MARK: - Init

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  private init(_ extendedType: ExtendedType) {
    self.rawValue = extendedType.rawValue
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return ExtendedType.allTypes
      .filter { self.contains(Extended($0)) }
      .reduce("") { memo, currentType in
        memo == "" ? "\(currentType)" : "\(memo),\(currentType)"
    }
  }
}

extension Extended {
  /// Converts the extended information into an array of query items.
  var parameters: [String: String] {
    return ["extended": self.description]
  }
}
