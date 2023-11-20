//
//  EtcRouter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import Foundation

import Moya

enum EtcRouter {
    case getRefreshToken
}

extension EtcRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .getRefreshToken:
            return "/refresh-token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRefreshToken:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRefreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRefreshToken:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
