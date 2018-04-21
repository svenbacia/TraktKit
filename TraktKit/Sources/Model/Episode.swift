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

    // MARK: - Init

    public init(season: Int, number: Int, title: String?, ids: Ids, numberAbs: Int?, overview: String?, rating: Double?, votes: Int?, firstAired: Date?, updatedAt: Date?, availableTranslations: [Translation]?, runtime: Int?) { //swiftlint:disable:this line_length
        self.season = season
        self.number = number
        self.title = title
        self.ids = ids
        self.numberAbs = numberAbs
        self.overview = overview
        self.rating = rating
        self.votes = votes
        self.firstAired = firstAired
        self.updatedAt = updatedAt
        self.availableTranslations = availableTranslations
        self.runtime = runtime
    }
}
