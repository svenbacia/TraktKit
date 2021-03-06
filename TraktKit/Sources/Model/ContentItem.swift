//
//  ContentItem.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public enum ContentItem {
    case movie(id: Int)
    case show(id: Int)
    case season(numbers: [Int], show: Int)
    case episode(id: Int)
    case episodes(numbers: [Int], season: Int, show: Int)
    case person(name: String, id: Int)
}

extension ContentItem {
    var asJSON: [String: Any] {
        switch self {
        case .movie(let id):
            return [
                "ids": [
                    "trakt": id
                ]
            ]
        case .show(let id):
            return [
                "ids": [
                    "trakt": id
                ]
            ]
        case .season(let numbers, let id):
            return [
                "seasons": numbers.map { ["number": $0] },
                "ids": id
            ]
        case .episode(let id):
            return [
                "ids": [
                    "trakt": id
                ]
            ]
        case .episodes(let numbers, let season, let show):
            return [
                "seasons": [
                    "number": season,
                    "episodes": numbers.map { ["number": $0] }
                ],
                "ids": show
            ]
        case .person(let name, let id):
            return [
                "name": name,
                "ids": ["trakt": id]
            ]
        }
    }
}
