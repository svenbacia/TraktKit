//
//  KeychainTests.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import XCTest

@testable import TraktKit

class KeychainTests: XCTestCase {
    
    private var keychain: Keychain = Keychain.default
    private let key = "test"
    
    override func tearDown() {
        super.tearDown()
        
        if let accounts = try? keychain.accounts() {
            accounts.forEach { try? keychain.removeObject(forKey: $0) }
        }
    }
        
    func testPassword() {        
        XCTAssertNoThrow(try keychain.setPassword("my-password-123"))
        
        if let password = try? keychain.password() {
            XCTAssertEqual("my-password-123", password)
        } else {
            XCTFail()
        }
    }
    
    func testGetString() {
        try? keychain.removeObject(forKey: key)
        
        XCTAssertNoThrow(try keychain.set("hello-123", forKey: key))
 
        if let string = try? keychain.string(forKey: key) {
            XCTAssertEqual("hello-123", string)
        } else {
            XCTFail("Keychain.string(for:) should return a valid string.")
        }
    }
    
    func testRemoveAll() throws {
        XCTAssertNoThrow(try keychain.set("hello-123", forKey: key))
        XCTAssertNoThrow(try keychain.setPassword("my-password-123"))
        let accounts = try keychain.accounts()
        XCTAssertEqual(accounts.count, 2)
        accounts.forEach { try? keychain.removeObject(forKey: $0) }
        let emptyAccounts = try keychain.accounts()
        XCTAssertTrue(emptyAccounts.isEmpty)
    }
}
