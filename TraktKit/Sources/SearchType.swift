//
//  SearchType.swift
//  TraktKit
//
//  Created by Sven Bacia on 28/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum SearchType: String, Codable {
    case movie
    case show
    case episode
    case person
    case list
}

extension SearchType: Equatable {
    public static func ==(lhs: SearchType, rhs: SearchType) -> Bool {
        switch (lhs, rhs) {
        case (.show, .show):
            return true
        case (.episode, .episode):
            return true
        case (.list, .list):
            return true
        case (.person, .person):
            return true
        case (.movie, .movie):
            return true
        default:
            return false
        }
    }
}
