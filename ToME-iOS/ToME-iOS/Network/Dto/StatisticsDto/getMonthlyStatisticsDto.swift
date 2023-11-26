//
//  getMonthlyStatisticsDto.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/25/23.
//

import Foundation

// MARK: - getMonthlyStatisticsDto

struct getMonthlyStatisticsDto: Codable {
    let statusCode: Int
    let detail: String
    let data: monthlyStatisticsData

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case detail, data
    }
}

// MARK: - monthlyStatisticsData

struct monthlyStatisticsData: Codable {
    let keywordCloudImageURL: String
    let emotionPercentages: EmotionPercentages
    let completedMissionCounts: [Int]

    enum CodingKeys: String, CodingKey {
        case keywordCloudImageURL = "keyword_cloud_image_url"
        case emotionPercentages = "emotion_percentages"
        case completedMissionCounts = "completed_mission_counts"
    }
}

// MARK: - EmotionPercentages

struct EmotionPercentages: Codable {
    let neutral, positive, negative: Double
}
