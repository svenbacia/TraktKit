//
//  Rating.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Rating {
  let rating: Double
  let votes: Int
  let distribution: [String : Int]
}

extension Rating: Unboxable {
  public init(unboxer: Unboxer) {
    rating       = unboxer.unbox(key: "rating")
    votes        = unboxer.unbox(key: "votes")
    distribution = unboxer.unbox(key: "distribution")
  }
}
