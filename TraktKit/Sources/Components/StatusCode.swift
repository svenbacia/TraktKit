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

        let prefix = "[\(self.rawValue)] "

        switch self {
        case .success:
            return prefix + "Success"
        case .successNewResourceCreated:
            return prefix + "Success - new resource created (POST)"
        case .successNoContentToReturn:
            return prefix + "Success - no content to return (DELETE)"
        case .badRequest:
            return prefix + "Bad Request - request couldn't be parsed"
        case .unauthorized:
            return prefix + "Unauthorized - OAuth must be provided"
        case .forbidden:
            return prefix + "Forbidden - Invalid API key or unapproved app"
        case .notFound:
            return prefix + "Not Found - method exists, but no record found"
        case .methodNotFound:
            return prefix + "Method Not Found - method doesn't exist"
        case .conflict:
            return prefix + "Conflict - resource already created"
        case .preconditionFailed:
            return prefix + "Precondition Failed - use application/json content type"
        case .unprocessableEntity:
            return prefix + "Unprocessable Entity - validation errors"
        case .rateLimitExceeded:
            return prefix + "Rate Limit Exceeded"
        case .serverError:
            return prefix + "Server Error"
        case .serverOverloaded:
            return prefix + "Service Unavailable - server overloaded"
        case .cloudflareError1,
             .cloudflareError2,
             .cloudflareError3:
            return prefix + "Service Unavailable - Cloudflare error"
        case .gatewayTimedOut:
            return prefix + "The web server reported a gateway time-out error. Please try again in a few minutes."
        }
    }
}

extension StatusCode: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        default:
            return ""
        }
    }
}
