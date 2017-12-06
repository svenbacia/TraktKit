//
//  SearchItem.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct SearchItem: Codable {
    public let type: SearchType
    public let score: Double
    public let show: Show?
    public let episode: Episode?
    public let person: Person?
    public let list: List?
}
