//
//  List.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct List: Codable {

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case privacy
        case displaysNumbers = "display_numbers"
        case allowComments = "allow_comments"
        case sortBy = "sort_by"
        case sortHow = "sort_how"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case itemCount = "item_count"
        case commentCount = "comment_count"
        case likes
        case ids
        case user
    }

    // MARK: - Properties

    public let name: String
    public let description: String?
    public let privacy: Privacy
    public let displaysNumbers: Bool
    public let allowComments: Bool
    public let sortBy: String
    public let sortHow: String
    public let createdAt: Date
    public let updatedAt: Date
    public let itemCount: Int
    public let commentCount: Int
    public let likes: Int
    public let ids: Ids
    public let user: User

    // MARK: - Init

    // swiftlint:disable:next line_length
    public init(name: String, description: String?, privacy: Privacy, displaysNumbers: Bool, allowComments: Bool, sortBy: String, sortHow: String, createdAt: Date, updatedAt: Date, itemCount: Int, commentCount: Int, likes: Int, ids: Ids, user: User) {
        self.name = name
        self.description = description
        self.privacy = privacy
        self.displaysNumbers = displaysNumbers
        self.allowComments = allowComments
        self.sortBy = sortBy
        self.sortHow = sortHow
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.itemCount = itemCount
        self.commentCount = commentCount
        self.likes = likes
        self.ids = ids
        self.user = user
    }
}
