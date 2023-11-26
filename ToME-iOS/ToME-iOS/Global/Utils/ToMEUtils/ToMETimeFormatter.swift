//
//  ToMETimeFormatter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import Foundation

class ToMETimeFormatter {
    static func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    static func getCurrentTimeToString(date: Date) -> String {
        return format(date: date, format: "yyyy.MM.dd HH:mm")
    }

    static func getCurrentDateToString(date: Date) -> String {
        return format(date: date, format: "yyyy-MM-dd")
    }

    static func getYearAndMonthToKorString(date: Date) -> String {
        return format(date: date, format: "yyyy년 MM월")
    }
    
    static func getYearAndMonthToHipenString(date: Date) -> String {
        return format(date: date, format: "yyyy-MM")
    }

    static func getMonthToString(date: Date) -> String {
        return format(date: date, format: "MM")
    }

    static func getYearToString(date: Date) -> String {
        return format(date: date, format: "YYYY")
    }
}
