//
//  Comment.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Comment: Codable {

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case id
        case parentId = "parent_id"
        case comment
        case isSpoiler = "spoiler"
        case isReview = "review"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case replies
        case likes
        case userRating = "user_rating"
        case user
    }

    // MARK: - Properties

    public let id: Int
    public let parentId: Int
    public let comment: String
    public let isSpoiler: Bool
    public let isReview: Bool
    public let createdAt: Date
    public let updatedAt: Date
    public let replies: Int
    public let likes: Int
    public let userRating: Int?
    public let user: User
}
