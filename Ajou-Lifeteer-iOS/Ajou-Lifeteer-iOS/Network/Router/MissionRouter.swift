//
//  MissionRouter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/19/23.
//

import Foundation

import Moya

enum MissionRouter {
    case getTotalMissions
}

extension MissionRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .getTotalMissions:
            return "/mission"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTotalMissions:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTotalMissions:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getTotalMissions:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
