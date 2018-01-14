//
//  Method.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

enum Method: String {

    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "UPDATE"

    public var allowsHttpBody: Bool {
        return self == .post
    }
}
