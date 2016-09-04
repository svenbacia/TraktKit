//
//  Image.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct Image {
  public let full: URL?
  public let medium: URL?
  public let thumb: URL?
}

extension Image: Unboxable {
  public init(unboxer: Unboxer) {
    full   = unboxer.unbox(key: "full")
    medium = unboxer.unbox(key: "medium")
    thumb  = unboxer.unbox(key: "thumb")
  }
}
