//
//  Person.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct Person: Codable {
    
    // MARK: - Person
    
    public let name: String
    public let ids: Ids
    public let biography: String?
    public let birthday: Date?
    public let death: Date?
    public let birthplace: String?
    public let homepage: String?
}
