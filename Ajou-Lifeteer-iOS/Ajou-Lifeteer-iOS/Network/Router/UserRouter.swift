//
//  UserRouter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import Foundation

import Moya

enum UserRouter {
    case authenticate(code: String) // Furo를 통해 가입
}

extension UserRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.furoBaseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/sessions/code/authenticate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .authenticate(let code):
            return .requestParameters(parameters: ["code": code], encoding: URLEncoding.httpBody)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .authenticate:
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "origin": Config.redirectURL]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

