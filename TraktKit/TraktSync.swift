//
//  TraktSync.swift
//  TraktKit
//
//  Created by Sven Bacia on 27/12/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
  
  public func lastActivities(_ completion: @escaping (Result<LastActivities, Error>) -> Void) -> URLSessionTask? {
    return load(resource: resource(for: "/sync/lastActivities"), authenticated: true, completion: completion)
  }
  
}
