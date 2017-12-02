//
//  ListItemType.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

// List Item Type can be used when quering the items from a list.
public enum ListItemType: String, Codable {
    case movies
    case shows
    case seasons
    case episodes
    case people
}
