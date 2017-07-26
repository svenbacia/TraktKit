//
//  Method.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

enum Method: String, CustomStringConvertible {
    case get
    case post
    case delete
    case update
    
    public var description: String {
        return self.rawValue.uppercased()
    }
}
