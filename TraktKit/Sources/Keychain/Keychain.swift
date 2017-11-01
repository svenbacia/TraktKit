//
//  Keychain.swift
//  Keychain
//
//  Created by Sven Bacia on 02.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation
import Security

public struct Keychain {
    
    // MARK: Types
    
    public enum Error: Swift.Error {
        case conversion
        case statusError(OSStatus)
    }
    
    // MARK: Properties
    
    /// Service
    public let service: String
    
    /// Optional account
    public let account: String?
    
    /// Access Group identifier
    public let accessGroup: String?
    
    // MARK: - Init
    
    /// Creates a new Keychain instance.
    ///
    /// - Parameters:
    ///   - service: Service
    ///   - accessGroup: Access group identifier
    ///   - account: Account
    public init(service: String, accessGroup: String? = nil, account: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: - Functions
    
    /// Stores password in keychain.
    ///
    /// - Parameter password: Password to be stored
    /// - Returns: Indicates if the password could be stored in the keychain
    public func setPassword(_ password: String) throws {
        guard let data = password.data(using: .utf8, allowLossyConversion: false) else {
            throw Error.conversion
        }
        try setPasswordData(data)
    }
    
    /// Stores password data in the keychain.
    ///
    /// - Parameter data: Password data to be stored.
    /// - Returns: Indicates if the password data could be stored.
    public func setPasswordData(_ data: Data) throws {
        let query = Query(service: service, accessGroup: accessGroup, account: account, data: data)
        try saveToKeychain(query)
    }
    
    
    /// Sets the value of the specified key to the specified string value.
    ///
    /// - Parameters:
    ///   - string: The string to store in the keychain.
    ///   - key: The key which to associate with the value.
    /// - Throws: Throws an error in case the string could not be stored.
    public func set(_ string: String?, forKey key: String) throws {
        try set(string?.data(using: .utf8, allowLossyConversion: false), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified data value.
    ///
    /// - Parameters:
    ///   - data: The data to store in the keychain.
    ///   - key: The key which to associate with the value.
    /// - Throws: Throws an error in case the data could not be stored.
    public func set(_ data: Data?, forKey key: String) throws {
        if let data = data {
            let query = Query(service: service, accessGroup: accessGroup, account: key, data: data)
            try saveToKeychain(query)
        } else {
            try removeObject(forKey: key)
        }
    }
    
    /// Fetches the password data for the current service and account from the keychain.
    ///
    /// - Returns: Returns the password data. If none is found `nil` is returned.
    public func passwordData() throws -> Data? {
        return try fetchPassword(with: Query(service: service, accessGroup: accessGroup, account: account))
    }
    
    /// Fetches the password for the current service and account from the keychain.
    ///
    /// - Returns: Returns the password. If none is found `nil` is returned.
    public func password() throws -> String? {
        guard let data = try passwordData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Returns the data associated with the specified key.
    ///
    /// - Parameter key: The associated key.
    /// - Returns: The data associated with the specified key.
    /// - Throws: Throws an error when an error occurs e.g. when the key could not be found.
    public func data(forKey key: String) throws -> Data? {
        return try fetchPassword(with: Query(service: service, accessGroup: accessGroup, account: key))
    }
    
    /// Returns the string associated with the specified key.
    ///
    /// - Parameter key: The associated key.
    /// - Returns: The string associated with the specified key.
    /// - Throws: Throws an error when an error occurs e.g. when the key could not be found.
    public func string(forKey key: String) throws -> String? {
        guard let data = try data(forKey: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Deletes the password for the current service and account from the keychain.
    ///
    /// - Returns: Indicates if the password could be deleted.
    public func deletePassword() throws {
        try delete(Query(service: service, accessGroup: accessGroup, account: account))
    }
    
    public func removeObject(forKey key: String) throws {
        try delete(Query(service: service, accessGroup: accessGroup, account: key))
    }
    
    /// Fetches all accounts who stored information in the keychain for the specified service.
    ///
    /// - Returns: Returns account names.
    public func accounts() throws -> [String] {
        let all = try fetchAll(with: Query(service: service, accessGroup: accessGroup))
        let accounts = all.flatMap { $0[String(kSecAttrAccount)] as? String }
        return accounts
    }
        
    // MARK: - Private
    
    private func saveToKeychain(_ query: Query) throws {
        // check if item already exists
        let request = query.request as CFDictionary
        var status = SecItemCopyMatching(request, nil)
                
        switch status {
        case errSecSuccess: // item already exists
            status = SecItemUpdate(request, query.attributes as CFDictionary)
        case errSecItemNotFound: // item not found
            status = SecItemAdd(request, nil)
        default:
            throw Error.statusError(status)
        }
        
        if status != errSecSuccess {
            throw Error.statusError(status)
        }
    }
    
    private func fetchPassword(with query: Query) throws -> Data? {
        var request = query.request
        request[String(kSecReturnData)] = true
        request[String(kSecMatchLimit)] = String(kSecMatchLimitOne)
        
        var result: AnyObject?
        let status = SecItemCopyMatching(request as CFDictionary, &result)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            throw Error.statusError(status)
        }
        
        if let data = result as? Data {
            return data
        }
        
        return nil
    }
    
    private func fetchAll(with query: Query) throws -> [[String: Any]] {
        var request = query.request
        request[String(kSecReturnAttributes)] = true
        request[String(kSecMatchLimit)] = String(kSecMatchLimitAll)
        
        var result: AnyObject?
        let status = SecItemCopyMatching(request as CFDictionary, &result)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            throw Error.statusError(status)
        }
        
        if let result = result as? [[String: Any]] {
            return result
        }
        
        return []
    }
    
    private func delete(_ query: Query) throws {
        let status = SecItemDelete(query.request as CFDictionary)
        if status != errSecSuccess {
            throw Error.statusError(status)
        }
    }
}

extension Keychain {
    public static var `default`: Keychain = Keychain(service: "TraktKit", account: "Token")
}
