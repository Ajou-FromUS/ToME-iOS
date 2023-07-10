//
//  Encodable+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import Foundation

// MARK: - Encodable Extension

extension Encodable {
    
  func asParameter() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            as? [String: Any] else {
        throw NSError()
    }
    return dictionary
  }
}
