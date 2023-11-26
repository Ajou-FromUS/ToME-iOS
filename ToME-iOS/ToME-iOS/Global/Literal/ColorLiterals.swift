//
//  ColorLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIColor {
    static var mainColor: UIColor {
        return UIColor(hex: "#5072EE")
    }
    
    static var sub1: UIColor {
        return UIColor(hex: "#ABBDFF")
    }
    
    static var sub2: UIColor {
        return UIColor(hex: "#E8EDFF")
    }
    
    static var sub3: UIColor {
        return UIColor(hex: "#45548C")
    }
    
    static var snackBackground: UIColor {
        return UIColor(hex: "#FFF1DA")
    }
    
    static var snackStroke: UIColor {
        return UIColor(hex: "#FFC09C")
    }
    
    static var snackText: UIColor {
        return UIColor(hex: "#FF6454")
    }
    
    static var disabled1: UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    static var disabled2: UIColor {
        return UIColor(hex: "#F1F1F1")
    }
    
    static var font1: UIColor {
        return UIColor(hex: "#232323")
    }
    
    static var font2: UIColor {
        return UIColor(hex: "#686868")
    }
    
    static var font3: UIColor {
        return UIColor(hex: "#A9A9A9")
    }
    
    static var font4: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var back1: UIColor {
        return UIColor(hex: "#FCFCFC")
    }
    
    static var alarmRed: UIColor {
        return UIColor(hex: "#FF5151")
    }
    
    static var kakaoYellow: UIColor {
        return UIColor(hex: "#FFE500")
    }
    
    static var appleBlack: UIColor {
        return UIColor(hex: "#232323")
    }
    
    static var snack: UIColor {
        return UIColor(hex: "#787878")
    }
    
    static var popUpBackground: UIColor {
        return UIColor(hex: "#545B73")
    }
    
    static var myPageBackground: UIColor {
        return UIColor(hex: "#F8F8F8")
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
