//
//  PeopleRequest.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public struct PeopleRequest {
    
    private let basePath: String
    
    public init(id: Int) {
        self.basePath = "/people/\(id)"
    }
    
//    public func summary(_ extended: Extended? = nil) -> Resource<Any> {
//        return buildResource(path: basePath, params: parameters(extended: extended))
//    }
//    
//    public func shows(_ extended: Extended? = nil) -> Resource<Any> {
//        return buildResource(path: basePath + "/shows", params: parameters(extended: extended))
//    }
//    
//    public func movies(_ extended: Extended? = nil) -> Resource<Data> {
//        return buildResource(path: basePath + "/movies", params: parameters(extended: extended))
//    }
}
