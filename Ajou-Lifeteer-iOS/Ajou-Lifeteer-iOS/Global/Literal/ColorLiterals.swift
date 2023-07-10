//
//  ColorLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIColor {
    static var mainGreen: UIColor {
        return UIColor(hex: "#62AA7F")
    }
    
    static var errorRed: UIColor {
        return UIColor(hex: "#BA1A1A")
    }
    
    static var mainBackground: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var textbox: UIColor {
        return UIColor(hex: "#F6F6F6")
    }
    
    static var mainBlack: UIColor {
        return UIColor(hex: "#232323")
    }
    
    static var disabledFill: UIColor {
        return UIColor(hex: "#E3E3E3")
    }
    
    static var disabledText: UIColor {
        return UIColor(hex: "#A1A1A1")
    }
    
    static var kakaoTalkYellow: UIColor {
        return UIColor(hex: "#FFE500")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

