//
//  TraktDateFormatter.swift
//  TraktKit
//
//  Created by Sven Bacia on 26.07.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension Trakt {
    public final class DateFormatter {
        public static let movieUpdateDateFormatter: Foundation.DateFormatter = {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
}
