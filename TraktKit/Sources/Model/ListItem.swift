//
//  ListItem.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct ListItem: Codable {
    
    // MARK: - Types
    
    public enum ItemType: String, Codable {
        case movie
        case show
        case season
        case episode
        case person
    }
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case listedAt = "listed_at"
        case type
        case show
        case season
        case episode
        case person
    }
    
    // MARK: - Properties
    
    public let rank: Int
    public let listedAt: Date
    public let type: ItemType
    public let show: Show?
    public let season: Season?
    public let episode: Episode?
    public let person: Person?
}
