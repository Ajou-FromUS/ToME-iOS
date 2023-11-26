//
//  ChatbotRouter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import Foundation

import Moya

enum ChatbotRouter {
    case sendMessage(content: String?) // 메세지 보내기
}

extension ChatbotRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .sendMessage:
            return "/chatbot"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendMessage:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendMessage(let content):
            return .requestParameters(parameters: ["content": content ?? NSNull()], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .sendMessage:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
