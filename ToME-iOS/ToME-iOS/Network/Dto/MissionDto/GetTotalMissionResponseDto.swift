//
//  GetTotalMissionResponseDto.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/19/23.
//

import Foundation

// MARK: - GetTotalMissionResponseDto

struct GetTotalMissionResponseDto: Codable {
    let statusCode: Int
    let detail: String
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let uid, missionID: Int?
    let isCompleted: Bool?
    let modifiedAt: String?
    let id: Int?
    let content: String?
    let createdAt: String?
    let mission: MissionList?

    enum CodingKeys: String, CodingKey {
        case uid
        case missionID = "mission_id"
        case isCompleted = "is_completed"
        case modifiedAt = "modified_at"
        case id, content
        case createdAt = "created_at"
        case mission
    }
}

// MARK: - MissionList
struct MissionList: Codable {
    let id, type: Int
    let title: String
    let content: String?
    let emotion: Int
}
