//
//  FontLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIFont {
    @nonobjc class var hLogin: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    @nonobjc class var h0: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 20)
    }
    
    @nonobjc class var h1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 16)
    }
    
    @nonobjc class var h2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 14)
    }
    
    @nonobjc class var h3: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 12)
    }
    
    @nonobjc class var h4: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 20)
    }
    
    @nonobjc class var h5: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    @nonobjc class var h6: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var h7: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    @nonobjc class var b0: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 20)
    }
    
    @nonobjc class var b1: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    @nonobjc class var b2: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 14)
    }
    
    @nonobjc class var b3: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 12)
    }
    
    @nonobjc class var b4: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 10)
    }
    
    @nonobjc class var landingPageTitleFont: UIFont {
        return UIFont.font(.gMarketSansLight, ofSize: 20)
    }
}

enum FontName: String {
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardBold = "Pretendard-Bold"
    case gMarketSansLight = "GmarketSansLight"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
