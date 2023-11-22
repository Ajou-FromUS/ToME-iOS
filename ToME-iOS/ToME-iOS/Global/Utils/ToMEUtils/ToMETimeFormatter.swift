//
//  ToMETimeFormatter.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import Foundation

class ToMETimeFormatter {
    static func getCurrentTimeToString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        return formatter.string(from: date)
    }
    
    static func getCurrentDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    static func getYearAndMonthToString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "yyyy년 MM월"
        
        return formatter.string(from: date)
    }
    
    static func getMonthToString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "MM"
        
        return formatter.string(from: date)
    }
    
    static func getYearToString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "YYYY"
        
        return formatter.string(from: date)
    }
}
