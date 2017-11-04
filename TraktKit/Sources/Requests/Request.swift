//
//  Request.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public class Request {
    
    // MARK: Properties
    let trakt: Trakt
    
    // MARK: Init
    init(trakt: Trakt) {
        self.trakt = trakt
    }
}
