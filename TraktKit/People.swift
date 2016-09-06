//
//  People.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct People {
  public let cast: [Cast<Person>]
  public let crew: [Crew]?
}

extension People: Unboxable {
  public init(unboxer: Unboxer) {
    cast = unboxer.unbox(key: "cast")
    crew = unboxer.unbox(key: "crew")
  }
}
