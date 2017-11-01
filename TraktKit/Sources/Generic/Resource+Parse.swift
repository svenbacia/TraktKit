//
//  Resource+Parse.swift
//  TraktKit
//
//  Created by Sven Bacia on 29.10.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

func parseJSON(_ data: Data, decoder: JSONDecoder?) throws -> Any {
    return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
}

func parseData(_ data: Data, decoder: JSONDecoder?) throws -> Data {
    return data
}

func parseDecodable<Element: Decodable>(_ data: Data, decoder: JSONDecoder?) throws -> Element {
    guard let decoder = decoder else { fatalError("missing decoder") }
    return try decoder.decode(Element.self, from: data)
}

//func parseToken(_ data: Data) throws -> Token {
//    
//    guard let json = try parseJSON(data, decoder: nil) as? [String: Any] else { throw TraktError.invalidResponseJson(buildError(reason: "Invalid format"), nil) }
//    
//    guard let refreshToken = json["refresh_token"] as? String else { throw TraktError.invalidResponseJson(buildError(reason: "Missing key refresh_token"), nil) }
//    guard let expiry = json["expires_in"] as? Double else { throw TraktError.invalidResponseJson(buildError(reason: "Missing key expires_in"), nil) }
//    guard let accessToken = json["access_token"] as? String else { throw TraktError.invalidResponseJson(buildError(reason: "Missing key access_token"), nil) }
//    
//    return Token(accessToken: accessToken, refreshToken: refreshToken, expiry: Date(timeIntervalSinceNow: expiry))
//}

