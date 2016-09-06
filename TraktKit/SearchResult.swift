//
//  SearchResult.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum SearchType: String {
  case movie
  case show
  case episode
  case person
  case list
}

extension SearchType: UnboxableEnum {
  public static func unboxFallbackValue() -> SearchType {
    return .show
  }
}


public struct SearchResult<T: Unboxable> {
  public let type: SearchType
  public let score: Double
  public let result: T
}

extension SearchResult: Unboxable {
  public init(unboxer: Unboxer) {
    type   = unboxer.unbox(key: "type")
    score  = unboxer.unbox(key: "score")
    result = unboxer.unbox(key: type.rawValue)
  }
}
