//
//  Ids.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Ids: Codable {
    // MARK: Properties
    public let trakt: Int
    public let slug: String
    public let tvdb: Int?
    public let imdb: String?
    public let tmdb: Int?
    public let tvrage: Int?
}
