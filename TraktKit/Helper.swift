//
//  Helper.swift
//  TraktKit
//
//  Created by Sven Bacia on 25/09/2016.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

func buildError(with code: StatusCode, reason: String? = nil, userInfo: [String: Any] = [:]) -> Error {
  var dict = userInfo
  dict[NSLocalizedDescriptionKey] = reason ?? code.description
  let error = NSError(domain: TraktErrorDomain, code: code.rawValue, userInfo: dict)
  return error
}

func toQueryItem(key: String, value: String) -> URLQueryItem {
  return URLQueryItem(name: key, value: value)
}
