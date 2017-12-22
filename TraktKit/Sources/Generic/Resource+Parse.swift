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
