//
//  TraktError.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
    public enum Error: LocalizedError {
        /// Authorization information are missing
        case missingAuthorization(String)

        /// Authorization inforamtion are invalid
        case invalidAuthorization(String)

        /// Unknown server response
        case unknownServerResponse(String, Swift.Error?)

        /// Unknown http status code
        case unknownHttpStatusCode(String, HTTPURLResponse, Swift.Error?)

        /// Bad http status code
        case badHttpStatusCode(String, StatusCode, Swift.Error?)

        /// Missing response data
        case missingResponseData(String, HTTPURLResponse, Swift.Error?)

        /// JSON decoding error
        case jsonDecodingError(String, Swift.Error)
    }
}

extension Trakt.Error {
    public var errorDescription: String? {
        return description
    }
}

extension Trakt.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .missingAuthorization:
            return "Unauthorized"
        case .invalidAuthorization:
            return "Invalid authorization"
        case .unknownServerResponse(_, let error):
            return error?.localizedDescription ?? "Unknown response"
        case .unknownHttpStatusCode:
            return "Unknown status code"
        case .badHttpStatusCode(_, let statusCode, _):
            return statusCode.description
        case .missingResponseData:
            return "Missing response data"
        case .jsonDecodingError:
            return "Invalid response"
        }
    }
}

extension Trakt.Error: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .missingAuthorization(let path):
            return "[\(path)] Authorization token is missing"
        case .invalidAuthorization(let path):
            return "[\(path)] Authorization information are invalid or expired"
        case .unknownServerResponse(let path, let error):
            let description = error?.localizedDescription ?? "Unknown server response"
            return "[\(path)] \(description)"
        case .unknownHttpStatusCode(let path, let response, _):
            return "[\(path)] Invalid HTTP status code (\(response.statusCode))."
        case .badHttpStatusCode(let path, let statusCode, _):
            return "[\(path)] Bad http status code: \(statusCode.debugDescription)."
        case .missingResponseData(let path, let response, _):
            return "[\(path)] Missing response data. \(response.debugDescription)."
        case .jsonDecodingError(let path, let error):
            if let debugDescription = (error as NSError).userInfo[NSDebugDescriptionErrorKey] as? String, !debugDescription.isEmpty {
                return "[\(path)] JSON Decoding Error: \(debugDescription)."
            } else {
                return "[\(path)] JSON Decoding Error: \(error.localizedDescription)."
            }
        }
    }
}

extension Trakt.Error: Equatable {
    public static func == (lhs: Trakt.Error, rhs: Trakt.Error) -> Bool {
        switch (lhs, rhs) {
        case (.missingAuthorization, .missingAuthorization):
            return true
        case (.invalidAuthorization, .invalidAuthorization):
            return true
        case (.unknownServerResponse, .unknownServerResponse):
            return true
        case (.unknownHttpStatusCode, .unknownHttpStatusCode):
            return true
        case (.badHttpStatusCode(_, let lhsStatusCode, _), .badHttpStatusCode(_, let rhsStatusCode, _)):
            return lhsStatusCode == rhsStatusCode
        case (.missingResponseData, .missingResponseData):
            return true
        case (.jsonDecodingError, .jsonDecodingError):
            return true
        default:
            return false
        }
    }
}
