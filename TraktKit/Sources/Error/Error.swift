//
//  TraktError.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
    public enum Error: Swift.Error {
        /// Authorization information are missing
        case missingAuthorization

        /// Authorization inforamtion are invalid
        case invalidAuthorization

        /// Unknown server response
        case unknownServerResponse(Swift.Error?)

        /// Unknown http status code
        case unknownHttpStatusCode(HTTPURLResponse, Swift.Error?)

        /// Bad http status code
        case badHttpStatusCode(StatusCode, Swift.Error?)

        /// Missing response data
        case missingResponseData(HTTPURLResponse, Swift.Error?)

        /// JSON decoding error
        case jsonDecodingError(Swift.Error)

        public var localizedDescription: String {
            return description
        }
    }
}

extension Trakt.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .missingAuthorization:
            return "Unauthorized"
        case .invalidAuthorization:
            return "Invalid Authorization"
        case .unknownServerResponse:
            return "Unknown Server Response"
        case .unknownHttpStatusCode:
            return "Invalid Server Response"
        case .badHttpStatusCode(let statusCode, _):
            return statusCode.description
        case .missingResponseData:
            return "Invalid Server Response"
        case .jsonDecodingError:
            return "Invalid Server Response"
        }
    }
}

extension Trakt.Error: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .missingAuthorization:
            return "Authorization token is missing"
        case .invalidAuthorization:
            return "Authorization information are invalid or expired"
        case .unknownServerResponse:
            return "Unknown server response."
        case .unknownHttpStatusCode(let response, _):
            return "Invalid HTTP status code (\(response.debugDescription))."
        case .badHttpStatusCode(let statusCode, _):
            return "Bad http status code: \(statusCode.debugDescription)."
        case .missingResponseData(let response, _):
            return "Missing response data. \(response.debugDescription)."
        case .jsonDecodingError(let error):
            return "JSON Decoding Error: \(error.localizedDescription)."
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
        case (.badHttpStatusCode(let lhsStatusCode, _), .badHttpStatusCode(let rhsStatusCode, _)):
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
