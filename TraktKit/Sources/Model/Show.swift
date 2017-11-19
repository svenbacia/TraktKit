//
//  Show.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public typealias Translation = String
public typealias Genre = String

public struct Show: Codable {
    
    // MARK: Types
    
    public struct Airs: Codable {
        public let day: String?
        public let time: String?
        public let timezone: String?
    }
    
    public enum Status: String, Codable {
        case returningSeries = "returning series"
        case inProducation = "in production"
        case planned
        case canceled
        case ended
        case unknown = ""
    }
    
    // MARK: - Codable coding keys
    
    private enum CodingKeys: String, CodingKey {
        case title
        case year
        case ids
        case overview
        case firstAired = "first_aired"
        case airs
        case runtime
        case certification
        case network
        case country
        case updatedAt = "updated_at"
        case homepage
        case status
        case rating
        case votes
        case language
        case availableTranslations = "available_translations"
        case genres
        case airedEpisodes = "aired_episodes"
    }
    
    // MARK: Properties
    
    public let title: String
    public let year: Int
    public let ids: Ids
    
    public let overview: String?
    public let firstAired: Date?
    public let airs: Airs?
    public let runtime: Int?
    public let certification: String?
    public let network: String?
    public let country: String?
    public let updatedAt: Date?
    public let homepage: String?
    public let status: Status?
    public let rating: Double?
    public let votes: Int?
    public let language: String?
    public let availableTranslations: [Translation]?
    public let genres: [Genre]?
    public let airedEpisodes: Int?
}
