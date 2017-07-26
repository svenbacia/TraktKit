//
//  Result.swift
//  TraktKit
//
//  Created by Sven Bacia on 04.09.16.
//  Copyright © 2016 Sven Bacia. All rights reserved.
//

import Foundation

public enum Result<T, E> {
  case success(T)
  case failure(E)
  
  public var value: T? {
    if case .success(let value) = self {
      return value
    }
    return nil
  }
  
  public var error: E? {
    if case .failure(let error) = self {
      return error
    }
    return nil
  }
  
}
