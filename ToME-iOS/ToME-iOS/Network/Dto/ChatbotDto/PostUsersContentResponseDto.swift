//
//  PostUsersContentResponseDto.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/13/23.
//

import Foundation

// MARK: - PostUsersContentResponseDto

struct PostUsersContentResponseDto: Codable {
    let statusCode: Int
    let detail: String
    let message: String?
    let missionCount: Int

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, message
        case missionCount = "mission_count"
    }
}
