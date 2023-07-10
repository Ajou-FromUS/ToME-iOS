//
//  UITabBar+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
