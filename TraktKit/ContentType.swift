//
//  ContentType.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum ContentType: CustomStringConvertible {
  
  case show(id: Int, title: String)
  case season(Int)
  case episode(id: Int, date: String?)
  case movie(id: Int, title: String, year: String)
  
  public var description: String {
    switch self {
    case .show:
      return "TV Show"
    case .season:
      return "Season"
    case .episode:
      return "Episode"
    case .movie:
      return "Movie"
    }
  }
}

func parameters(with contentTypes: [ContentType]) -> [String : Any] {
  var shows = [[String : Any]]()
  var episodes = [[String : Any]]()
  
  for case .show(let id, _) in contentTypes {
    shows.append([ "ids" : [ "trakt" : id ] ])
  }
  
  for case .episode(let id, let date) in contentTypes {
    var episode: [String: Any] = [ "ids" : [ "trakt" : id ] ]
    if let date = date {
      episode["watched_at"] = date
    }
    episodes.append(episode)
  }
  
  return [
    "shows" : shows,
    "episodes" : episodes
  ]
}
