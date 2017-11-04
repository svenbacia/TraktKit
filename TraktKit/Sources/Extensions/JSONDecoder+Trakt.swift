//
//  JSONDecoder+Trakt.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    public static var trakt: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(iso8601DateFormatter)
        return decoder
    }
    
    public static var timeIntervalSinceNow: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let expiry: Double = try container.decode(Double.self)
            return Date(timeIntervalSinceNow: expiry)
        })
        return decoder
    }
    
    // MARK: - Private Helper
    
    private static var iso8601DateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }
}
