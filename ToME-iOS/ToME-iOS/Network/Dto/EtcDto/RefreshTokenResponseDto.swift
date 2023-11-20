//
//  RefreshTokenResponseDto.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/13/23.
//

import Foundation

// MARK: - RefreshTokenResponseDto

struct RefreshTokenResponseDto: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
