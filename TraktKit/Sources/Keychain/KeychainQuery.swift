//
//  KeychainQuery.swift
//  TraktKit
//
//  Created by Sven Bacia on 01.11.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

extension Keychain {
    struct Query {
        
        // MARK: Properties
        
        let service: String
        let accessGroup: String?
        let account: String?
        var data: Data?
        
        // MARK: - Init
        
        init(service: String, accessGroup: String? = nil, account: String? = nil, data: Data? = nil) {
            self.service = service
            self.account = account
            self.data = data
            self.accessGroup = accessGroup
        }
        
        // MAKR: -
        
        /// A dictionary containing an item class specification and
        /// optional attributes for controlling the search.
        var request: [String: Any] {
            var dictionary = [String: Any]()
            dictionary[kSecClass as String] = kSecClassGenericPassword
            dictionary[kSecAttrService as String] = service
            dictionary[String(kSecAttrSynchronizable)] = kCFBooleanFalse
            dictionary[String(kSecAttrAccessible)] = kSecAttrAccessibleAfterFirstUnlock
            
            if let accessGroup = accessGroup {
                dictionary[kSecAttrAccessGroup as String] = accessGroup
            }
            
            if let account = account {
                dictionary[kSecAttrAccount as String] = account
            }
            
            if let data = data {
                dictionary[kSecValueData as String] = data
            }
            
            return dictionary
        }
        
        /// A dictionary containing one or more attributes
        /// whose values should be set to the ones specified. Only real keychain
        /// attributes are permitted in this dictionary (no "meta" attributes are
        /// allowed.)
        var attributes: [String: Any] {
            var dictionary = [String: Any]()
            if let data = data {
                dictionary[String(kSecValueData)] = data
            }
            return dictionary
        }
    }
}
