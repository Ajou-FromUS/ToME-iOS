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
    case patchTextOrDecibelMissionUpdate(id: Int, content: String)
    case patchImageMissionUpdate(id: Int, missionImage: NSData)
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
            return "/user/mission/\(ToMETimeFormatter.getCurrentDateToString(date: Date()))"
        case .patchTextOrDecibelMissionUpdate(let id, _), .patchImageMissionUpdate(let id, _):
            return "/user/mission/\(String(id))"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTotalMissions:
            return .get
        case .patchTextOrDecibelMissionUpdate, .patchImageMissionUpdate:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTotalMissions:
            return .requestPlain
        case .patchTextOrDecibelMissionUpdate(_, let content):
            return .requestParameters(parameters: ["content": content], encoding: JSONEncoding.default)
        case .patchImageMissionUpdate(_, let missionImage):
            let formData = MultipartFormData(provider: .data(missionImage as Data),
                                                     name: "mission_image", fileName: "image.jpeg", mimeType: "image/jpeg")
            return .uploadMultipart([formData])
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getTotalMissions, .patchTextOrDecibelMissionUpdate, .patchImageMissionUpdate:
            return Config.headerWithAccessToken
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
