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
    case initClient
}

extension UserRouter: TargetType {
    var baseURL: URL {
        switch self {
        case .authenticate:
            guard let url = URL(string: Config.furoBaseURL) else {
                fatalError("baseURL could not be configured")
            }
            
            return url
        case .initClient:
            guard let url = URL(string: Config.baseURL) else {
                fatalError("baseURL could not be configured")
            }
            
            return url
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/sessions/code/authenticate"
        case .initClient:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate:
            return .post
        case . initClient:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .authenticate(let code):
            return .requestParameters(parameters: ["code": code], encoding: URLEncoding.httpBody)
        case .initClient:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .authenticate:
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "origin": Config.redirectURL]
        case .initClient:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
