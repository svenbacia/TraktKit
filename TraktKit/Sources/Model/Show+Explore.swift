//
//  Show+Explore.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public struct TrendingShow: Codable {
    public let watchers: Int
    public let show: Show
}

public typealias WatchedShow = PlayedShow
public typealias CollectedShow = PlayedShow

public struct PlayedShow: Codable {
    
    // MARK: Codable
    private enum CodingKeys: String, CodingKey {
        case watchers = "watcher_count"
        case plays = "play_count"
        case collected = "collected_count"
        case collectors = "collector_count"
        case show
    }
    
    // MARK: Properties
    public let watchers: Int
    public let plays: Int
    public let collected: Int
    public let collectors: Int
    public let show: Show
}

public struct AnticipatedShow: Codable {
    
    // MARK: Codable
    private enum CodingKeys: String, CodingKey {
        case listed = "list_count"
        case show
    }
    
    // MARK: Properties
    public let listed: Int
    public let show: Show
}
