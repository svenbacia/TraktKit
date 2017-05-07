//
//  FakeURLSession.swift
//  TraktKit
//
//  Created by Sven Bacia on 06.05.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation
import TraktKit

final class FakeURLSession: URLSession {
    
    // MARK: - Types
    
    private final class Task: URLSessionDataTask {
        
        private let completion: (Void) -> Void
        
        init(completion: @escaping (Void) -> Void) {
            self.completion = completion
            super.init()
        }
        
        override func resume() {
            completion()
        }
    }
    
    // MARK: - Properties
    
    private let handler: (URLRequest) -> (Data?, URLResponse?, Error?)
    
    var requests = [URLRequest]()
    var completedRequests = [URLRequest]()
        
    // MARK: - Init
    
    init(handler: @escaping (URLRequest) -> (Data?, URLResponse?, Error?)) {
        self.handler = handler
    }
    
    convenience init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.init { (_) -> (Data?, URLResponse?, Error?) in
            return (data, response, error)
        }
    }
        
    // MARK: - Task
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requests.append(request)
        return Task {
            self.completedRequests.append(request)
            let result = self.handler(request)
            completionHandler(result.0, result.1, result.2)
        }
    }
    
    // MARK: - Reset 
    
    func reset() {
        requests.removeAll()
        completedRequests.removeAll()
    }
}

func buildData(with json: Any) -> Data {
    return try! JSONSerialization.data(withJSONObject: json, options: [])
}
