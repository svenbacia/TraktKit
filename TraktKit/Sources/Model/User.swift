//
//  User.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct User: Codable {

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case username
        case isPrivate = "private"
        case name
        case isVip = "vip"
        case isVipEp = "vip_ep"
        case ids
        case joinedAt = "joined_at"
        case location
        case about
        case gender
        case age
        case images
    }

    // MARK: - Types

    public struct Ids: Codable {
        let slug: String
    }

    public struct Images: Codable {
        let avatar: Image
    }

    // MARK: - Properties

    public let username: String
    public let isPrivate: Bool
    public let name: String?
    public let isVip: Bool?
    public let isVipEp: Bool?
    public let ids: Ids
    public let joinedAt: Date?
    public let location: String?
    public let about: String?
    public let gender: String?
    public let age: Int?
    public let images: Images?
}
