//
//  initClientDto.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/25/23.
//

import Foundation

// MARK: - initClientDto

struct initClientDto: Codable {
    let statusCode: Int
    let detail: String
    let data: initClientData

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, data
    }
}

// MARK: - initClientData

struct initClientData: Codable {
    let nickname: String
    let hasMissionToday: Bool

    enum CodingKeys: String, CodingKey {
        case nickname
        case hasMissionToday = "has_mission_today"
    }
}
