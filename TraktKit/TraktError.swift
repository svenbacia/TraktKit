//
//  TraktError.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public enum TraktError: Error {
    case badStatusCode(StatusCode, Error?)
    case invalidAuthorization
    case invalidResponseData(Error?)
    case invalidResponseJson(Error)
    case unknownServerResponse(Error?)
    case unknownStatusCode(Int, Error?)
}

extension TraktError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badStatusCode(let statusCode, let error):
            return buildDescription("Bad Status Code: \(statusCode.description)", with: error)
        case .invalidAuthorization:
            return "Authorization token is invalid or expired"
        case .invalidResponseData(let error):
            return buildDescription("Invalid response data", with: error)
        case .invalidResponseJson(let error):
            return "Invalid response json. \(error.localizedDescription)"
        case .unknownServerResponse(let error):
            return buildDescription("Unknown server response", with: error)
        case .unknownStatusCode(let statusCode, let error):
            return buildDescription("Unknown status code \(statusCode)", with: error)
        }
    }
}

fileprivate func buildDescription(_ message: String, with error: Error?) -> String {
    guard let error = error else { return message }
    return message.appending(". \(error.localizedDescription)")
}
