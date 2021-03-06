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

    override func setUp() {
        super.setUp()
        if let accounts = try? keychain.accounts() {
            accounts.forEach { try? keychain.removeObject(forKey: $0) }
        }
    }

    func testPassword() {
        XCTAssertNoThrow(try keychain.setPassword("my-password-123"))

        if let password = try? keychain.password() {
            XCTAssertEqual("my-password-123", password)
        } else {
            XCTFail("expected stored password")
        }

        try! keychain.deletePassword()

        XCTAssertNil(try! keychain.password())
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
        XCTAssertNoThrow(try keychain.set("123-hello", forKey: "some key"))
        let accounts = try keychain.accounts()
        XCTAssertEqual(accounts.count, 2)
        accounts.forEach { try? keychain.removeObject(forKey: $0) }
        let emptyAccounts = try keychain.accounts()
        XCTAssertTrue(emptyAccounts.isEmpty)
    }

    func testQuery() {
        let query = Keychain.Query(service: "service", accessGroup: "accessGroup", account: "account", data: nil)
        let request = query.request
        XCTAssertEqual(request[kSecAttrService as String] as! String, "service")
        XCTAssertEqual(request[kSecAttrAccessGroup as String] as! String, "accessGroup")
        XCTAssertEqual(request[kSecAttrAccount as String] as! String, "account")
    }
}
