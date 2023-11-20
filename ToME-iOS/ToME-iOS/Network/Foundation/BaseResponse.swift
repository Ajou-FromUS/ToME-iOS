//
//  BaseResponse.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/13/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
}

/// data가 없는 API 통신에서 사용할 BlankData 구조체
struct BlankData: Codable {
}
