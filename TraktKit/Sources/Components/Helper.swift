//
//  Helper.swift
//  TraktKit
//
//  Created by Sven Bacia on 25/09/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

func buildError(reason: String) -> Error {
    let dict = [
        NSLocalizedDescriptionKey: reason
    ]
    return NSError(domain: TraktErrorDomain, code: 599, userInfo: dict)
}

func toQueryItem(key: String, value: String) -> URLQueryItem {
    return URLQueryItem(name: key, value: value)
}
