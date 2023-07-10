//
//  Result+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import Foundation

extension Result {
    @discardableResult
    func success(_ successHandler: (Success) -> Void) -> Result<Success, Failure> {
        if case .success(let value) = self {
            successHandler(value)
        }
        return self
    }
    
    @discardableResult
    func `catch`(_ failureHandler: (Failure) -> Void) -> Result<Success, Failure> {
        if case .failure(let error) = self {
            failureHandler(error)
        }
        return self
    }
}
