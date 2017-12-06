//
//  People.swift
//  TraktKit
//
//  Created by Sven Bacia on 05.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct People: Codable {
    
    // MARK: - Types
    
    public struct Shows: Codable {
        public let cast: [Show]
    }
    
    public struct Show: Codable {
        public let character: String
        public let show: TraktKit.Show
    }
    
    // MARK: - Properties
    
    public let character: String
    public let person: Person
}
