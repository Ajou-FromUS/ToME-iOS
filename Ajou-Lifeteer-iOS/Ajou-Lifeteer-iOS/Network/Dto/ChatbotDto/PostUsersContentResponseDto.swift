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
    let detail, message: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, message
    }
}
