//
//  StatisticsRouter.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/25/23.
//

import Foundation

import Moya

enum StatisticsRouter {
    case getMonthlyStatistic(yearAndMonth: String)
}

extension StatisticsRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .getMonthlyStatistic(let yearAndMonth):
            return "/statistics/" + yearAndMonth
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMonthlyStatistic:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMonthlyStatistic:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getMonthlyStatistic:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
