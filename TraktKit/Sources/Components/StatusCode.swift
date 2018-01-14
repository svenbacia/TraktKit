//
//  ErrorCode.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

/**
 * The API will respond with one of the following HTTP status codes.
 */
public enum StatusCode: Int, Error {
    /// Success
    case success = 200

    /// Success - new resource created (POST)
    case successNewResourceCreated = 201

    /// Success - no content to return (DELETE)
    case successNoContentToReturn = 204

    /// Bad Request - request couldn't be parsed
    case badRequest = 400

    /// Unauthorized - OAuth must be provided
    case unauthorized = 401

    /// Forbidden - Invalid API key or unapproved app
    case forbidden = 403

    /// Not Found - method exists, but no record found
    case notFound = 404

    /// Method Not Found - method doesn't exist
    case methodNotFound = 405

    /// Conflict - resource already created
    case conflict = 409

    /// Precondition Failed - use application/json content type
    case preconditionFailed = 412

    /// Unprocessable Entity - validation errors
    case unprocessableEntity = 422

    /// Rate Limit Exceeded
    case rateLimitExceeded = 429

    /// Server Error
    case serverError = 500

    /// Service Unavailable - server overloaded
    case serverOverloaded = 503

    /// The web server reported a gateway time-out error. Please try again in a few minutes.
    case gatewayTimedOut = 504

    /// Service Unavailable - Cloudflare error
    case cloudflareError1 = 520

    /// Service Unavailable - Cloudflare error
    case cloudflareError2 = 521

    /// Service Unavailable - Cloudflare error
    case cloudflareError3 = 522
}

extension StatusCode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .success:
            return "Success"
        case .successNewResourceCreated:
            return "Success - new resource created (POST)"
        case .successNoContentToReturn:
            return "Success - no content to return (DELETE)"
        case .badRequest:
            return "Bad Request - request couldn't be parsed"
        case .unauthorized:
            return "Unauthorized - OAuth must be provided"
        case .forbidden:
            return "Forbidden - Invalid API key or unapproved app"
        case .notFound:
            return "Not Found - method exists, but no record found"
        case .methodNotFound:
            return "Method Not Found - method doesn't exist"
        case .conflict:
            return "Conflict - resource already created"
        case .preconditionFailed:
            return "Precondition Failed - use application/json content type"
        case .unprocessableEntity:
            return "Unprocessable Entity - validation errors"
        case .rateLimitExceeded:
            return "Rate Limit Exceeded"
        case .serverError:
            return "Server Error"
        case .serverOverloaded:
            return "Service Unavailable - server overloaded"
        case .cloudflareError1,
             .cloudflareError2,
             .cloudflareError3:
            return "Service Unavailable - Cloudflare error"
        case .gatewayTimedOut:
            return "The web server reported a gateway time-out error. Please try again in a few minutes."
        }
    }
}

extension StatusCode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\((rawValue)) \(description)"
    }
}
