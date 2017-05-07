//
//  TraktError.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public enum TraktError: Error {
    case badStatusCode(StatusCode, URL?, Error?)
    case invalidAuthorization
    case invalidResponseData(URL?, Error?)
    case invalidResponseJson(Error, URL?)
    case unknownServerResponse(Error?)
    case unknownStatusCode(Int, URL?, Error?)
}

extension TraktError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badStatusCode(let statusCode, let url, let error):
            return buildDescription("Bad Status Code: \(statusCode.description)", url: url, with: error)
        case .invalidAuthorization:
            return "Authorization token is invalid or expired"
        case .invalidResponseData(let url, let error):
            return buildDescription("Invalid response data", url: url, with: error)
        case .invalidResponseJson(let error, let url):
            return buildDescription("Invalid response json. \(error.localizedDescription)", url: url)
        case .unknownServerResponse(let error):
            return buildDescription("Unknown server response", with: error)
        case .unknownStatusCode(let statusCode, let url, let error):
            return buildDescription("Unknown status code \(statusCode)", url: url, with: error)
        }
    }
}

fileprivate func buildDescription(_ message: String, url: URL? = nil, with error: Error? = nil) -> String {
    var description = ""
    
    if let path = url?.path {
        description = "[\(path)] \(message)"
    } else {
        description = message
    }
    
    if let error = error {
        description.append(". \(error.localizedDescription)")
    }
    
    return description
}
