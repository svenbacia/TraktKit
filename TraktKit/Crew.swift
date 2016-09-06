//
//  Crew.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Crew {
  public let job: String
  public let person: Person
}

extension Crew: Unboxable {
  public init(unboxer: Unboxer) {
    job    = unboxer.unbox(key: "job")
    person = unboxer.unbox(key: "person")
  }
}
