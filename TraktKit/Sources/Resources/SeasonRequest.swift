//
//  SeasonRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct SeasonRequest {

  // MARK: - Properties

  private let show: Int
  private let season: Int
  private let basePath: String

  // MARK: - Init

  init(id: Int, number: Int) {
    self.show = id
    self.season = number
    self.basePath = "/shows/\(id)/seasons/\(number)"
  }

  // MARK: - Endpoints

//  public func summary(_ extended: Extended? = nil) -> Resource<Any> {
//    return buildResource(path: basePath, params: parameters(extended: extended))
//  }
//  
//  public func comments(_ page: Int? = nil, limit: Int? = nil) -> Resource<Any> {
//    return buildResource(path: basePath + "/comments", params: parameters(page: page, limit: limit))
//  }
//  
//  public func ratings() -> Resource<Any> {
//    return buildResource(path: basePath + "/ratings")
//  }
//  
//  public func stats() -> Resource<Any> {
//    return buildResource(path: basePath + "/stats")
//  }
//  
//  public func watching(_ extended: Extended? = nil) -> Resource<Any> {
//    return buildResource(path: basePath + "/watching", params: parameters(extended: extended))
//  }

  // MARK: - Episode Request

  public func episode(_ number: Int) -> EpisodeRequest {
    return EpisodeRequest(show: show, season: season, number: number)
  }

}
