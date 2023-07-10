//
//  calculateStatusBarHeight.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .compactMap {
                $0.statusBarManager
            }
            .map {
                $0.statusBarFrame
            }
            .map(\.height)
            .max() ?? 0
    }
}
