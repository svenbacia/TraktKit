//
//  PersonRelated.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct PersonRelated {
  public let cast: [Cast<Show>]
}

extension PersonRelated: Unboxable {
  public init(unboxer: Unboxer) {
    cast = unboxer.unbox(key: "cast")
  }
}
