//
//  adjusted+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

/**
 - Description:
 스크린 너비 375를 기준으로 디자인이 나왔을 때 현재 기기의 스크린 사이즈에 비례하는 수치를 Return한다.
 
 - Note:
 기기별 대응에 사용하면 된다.
 ex) (size: 20.adjusted)
 */

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 390
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 844
        return self * ratio
    }
}

extension Double {
    var adjusted: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 390)
        return self * ratio
    }
    
    var adjustedH: Double {
        let ratio: Double = Double(UIScreen.main.bounds.height / 844)
        return self * ratio
    }
}

