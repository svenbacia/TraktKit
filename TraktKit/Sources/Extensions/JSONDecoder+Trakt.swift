//
//  JSONDecoder+Trakt.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

public enum JSONError: Error {
    case invalidDateFormat(String)
}

extension JSONDecoder {
    
    public static var trakt: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeDate)
        return decoder
    }
    
    private static func decodeDate(_ decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let formatter = dateFormatter(for: string)
        if let date = formatter.date(from: string) {
            return date
        } else {
            throw JSONError.invalidDateFormat(string)
        }
    }
    
    private static func dateFormatter(`for` string: String) -> DateFormatter {
        if string.count == 10 {
            return dateFormatter
        } else {
            return iso8601DateFormatter
        }
    }
    
    public static var timeIntervalSinceNow: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let expiry = try container.decode(Double.self)
            return Date(timeIntervalSinceNow: expiry)
        })
        return decoder
    }
    
    // MARK: - Private Helper
    
    private static let iso8601DateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
