//
//  Resource+Parameters.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func parameters(with params: [String: String]? = nil, page: Int? = nil, limit: Int? = nil, extended: Extended? = nil) -> [String: String]? {
    var params = params ?? [String: String]()

    if let page = page {
        params["page"] = String(page)
    }

    if let limit = limit {
        params["limit"] = String(limit)
    }

    extended?.parameters.forEach { (key, value) in params[key] = value }

    return params.isEmpty ? nil : params
}
