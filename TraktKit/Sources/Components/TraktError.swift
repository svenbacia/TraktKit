//
//  TraktError.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public enum TraktError: Error {
    case missingRefreshToken
    case badStatusCode(StatusCode, URLRequest?, Error?)
    case invalidAuthorization
    case invalidResponseData(URLRequest?, Error?)
    case invalidResponseJson(Error, URLRequest?)
    case unknownServerResponse(Error?)
    case unknownStatusCode(Int, URLRequest?, Error?)
}

extension TraktError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badStatusCode(let statusCode, let request, let error):
            return buildDescription("Bad Status Code: \(statusCode.description)", request: request, with: error)
        case .invalidAuthorization:
            return "Authorization token is invalid or expired"
        case .invalidResponseData(let request, let error):
            return buildDescription("Invalid response data", request: request, with: error)
        case .invalidResponseJson(let error, let request):
            return buildDescription("Invalid response json. \(error.localizedDescription)", request: request)
        case .unknownServerResponse(let error):
            return buildDescription("Unknown server response", with: error)
        case .unknownStatusCode(let statusCode, let request, let error):
            return buildDescription("Unknown status code \(statusCode)", request: request, with: error)
        case .missingRefreshToken:
            return buildDescription("Refresh token is missing.")
        }
    }
}

fileprivate func buildDescription(_ message: String, request: URLRequest? = nil, with error: Error? = nil) -> String {
    var description = "--------------------------------------\n"
    
    description.append("Info: \(message)\n")
    
    if let url = request?.url {
        description.append("Request: \(url)\n")
    }
    
    if let data = request?.httpBody, let payload = String(data: data, encoding: .utf8) {
        description.append("Payload: \(payload)\n")
    }
    
    if let error = error {
        description.append("Error: \(error.localizedDescription)\n")
    }
    
    description.append("--------------------------------------")
    
    return description
}
