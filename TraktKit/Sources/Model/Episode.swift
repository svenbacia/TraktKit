//
//  Episode.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Episode: Codable {

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case season
        case number
        case title
        case ids
        case numberAbs = "number_abs"
        case overview
        case rating
        case votes
        case firstAired = "first_aired"
        case updatedAt = "updated_at"
        case availableTranslations = "available_translations"
        case runtime
    }

    // MARK: - Properties

    public let season: Int
    public let number: Int
    public let title: String?
    public let ids: Ids
    public let numberAbs: Int?
    public let overview: String?
    public let rating: Double?
    public let votes: Int?
    public let firstAired: Date?
    public let updatedAt: Date?
    public let availableTranslations: [Translation]?
    public let runtime: Int?
}
