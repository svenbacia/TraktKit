//
//  File.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Cast<T> where T: Unboxable, T: KeyType {
  public let character: String
  public let item: T
}

extension Cast: Unboxable {
  public init(unboxer: Unboxer) {
    character = unboxer.unbox(key: "character")
    item = unboxer.unbox(key: T.key)
  }
}
