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
    let data: [MissionData]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, data
    }
}

// MARK: - MissionData
struct MissionData: Codable {
    let id, type: Int
    let title: String
    let content: String?
    let emotion: Int
}
