//
//  Keychain.swift
//  Keychain
//
//  Created by Sven Bacia on 02.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation
import Security

private let isSimulator = TARGET_OS_SIMULATOR != 0

public struct Keychain {
  
  // MARK: Properties
  
  public let service: String
  public let accessGroup: String?
  
  // MARK: - Init
  
  public init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
  
  // MARK: - Set Data
  
  @discardableResult
  public func set(string: String?, forKey key: String) -> Bool {
    
    // when string is nil, delete item
    guard let string = string else { return deleteItem(for: key) }
    
    // check if string can be converted to data
    guard let data = string.data(using: .utf8) else { return false }
    
    return set(data: data, forKey: key)
  }
  
  @discardableResult
  public func set(data: Data?, forKey key: String) -> Bool {
    
    // when data is nil, remove the item from the keychain
    guard let data = data else { return deleteItem(for: key) }
    
    // setup attributes
    let attributes: [String : Any] = [
      kSecClass as String : kSecClassGenericPassword,
      kSecAttrService as String : service(for: key),
      kSecValueData as String : data,
      kSecAttrAccessible as String : kSecAttrAccessibleAlways as String,
    ]
    
    // add item
    var result = SecItemAdd(attributes as CFDictionary, nil)
    
    // when item already exists and could be deleted
    // try to add it again
    if result == errSecDuplicateItem && deleteItem(for: key) {
      result = SecItemAdd(attributes as CFDictionary, nil)
    }
    
    // check for error
    if result != noErr {
      print("SecItemAdd failed for key \(key): \(result)")
    }
    
    return result == noErr
    
  }
  
  // MARK: - Get Data
  
  public func data(for key: String) -> Data? {
    
    let query: [String: Any] = [
      kSecClass as String : kSecClassGenericPassword,
      kSecAttrService as String : service(for: key),
      kSecReturnData as String : kCFBooleanTrue,
      kSecMatchLimit as String : kSecMatchLimitOne
    ]
    
    var result: AnyObject?
    
    let resultCode = withUnsafeMutablePointer(to: &result) { pointer in
      SecItemCopyMatching(query as CFDictionary, pointer)
    }
    
    guard resultCode == noErr else { return nil }
    guard let data = result as? Data else { return nil }
    
    return data
  }
  
  public func string(for key: String) -> String? {
    guard let data = data(for: key) else { return nil }
    return String(data: data, encoding: .utf8)
  }
  
  // MARK: - Delete Data
  
  @discardableResult public func deleteItem(for key: String) -> Bool {
    
    let query: [String : Any] = [
      kSecClass as String : kSecClassGenericPassword,
      kSecAttrService as String : service(for: key)
    ]
    
    let resultCode = SecItemDelete(query as CFDictionary)
    
    return resultCode == noErr || resultCode == errSecItemNotFound
  }
  
  // MARK: - Convenience
  
  private func service(for key: String) -> String {
    return self.service.appending(".\(key)")
  }
  
  // MARK: - Subscript
  
  public subscript(key: String) -> String? {
    get {
      return string(for: key)
    }
    set {
      set(string: newValue, forKey: key)
    }
  }
  
  public subscript(data key: String) -> Data? {
    get {
      return data(for: key)
    }
    set {
      set(data: newValue, forKey: key)
    }
  }
  
}
