//
//  Resource+Path.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func path(_ path: String, with period: Period? = nil) -> String {
    guard let period = period else { return path }
    return path.appending("/\(period.rawValue)")
}

func buildPath(_ path: String, type: ListItemType?) -> String {
    guard let type = type else { return path }
    return path.appending("/\(type.rawValue)")
}
