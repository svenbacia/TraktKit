//
//  Ratings.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Ratings: Codable {
    
    // MARK: - Properties
    
    public let rating: Double
    public let votes: Int
    public let distribution: [String: Int]
}
