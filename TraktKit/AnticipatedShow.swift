//
//  AnticipatedShow.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct AnticipatedShow {
  public let show: Show
  public let lists: Int
}

extension AnticipatedShow: Unboxable {
  public init(unboxer: Unboxer) {
    show = unboxer.unbox(key: "show")
    lists = unboxer.unbox(key: "list_count")
  }
}
