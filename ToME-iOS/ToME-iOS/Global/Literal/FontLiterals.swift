//
//  FontLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIFont {
    @nonobjc class var title1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    @nonobjc class var title2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 20)
    }
    
    @nonobjc class var title3: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 16)
    }
    
    @nonobjc class var title4: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 12)
    }
    
    @nonobjc class var subTitle1: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 20)
    }
    
    @nonobjc class var subTitle2: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 16)
    }
    
    @nonobjc class var subTitle3: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 12)
    }
    
    @nonobjc class var body1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var newBody1: UIFont {
        return UIFont.font(.leeSeoyun, ofSize: 24)
    }
    
    @nonobjc class var body2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    @nonobjc class var newBody2: UIFont {
        return UIFont.font(.leeSeoyun, ofSize: 20)
    }
    
    @nonobjc class var body3: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 10)
    }
    
    @nonobjc class var newBody3: UIFont {
        return UIFont.font(.leeSeoyun, ofSize: 16)
    }
    
    @nonobjc class var newBody4: UIFont {
        return UIFont.font(.leeSeoyun, ofSize: 14)
    }
    
    @nonobjc class var bubbleEmoji: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 24)
    }
    
    @nonobjc class var tabbar: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    @nonobjc class var snack: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 10)
    }
    
    @nonobjc class var logo: UIFont {
        return UIFont.font(.yDestreetL, ofSize: 12)
    }
    
    @nonobjc class var questionNumber: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 36)
    }
}

enum FontName: String {
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case coinyCyrillic = "Coiny-Cyrillic"
    case yDestreetL = "YdestreetL"
    case gMarketSansLight = "GmarketSansLight"
    case leeSeoyun = "LeeSeoyun"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
