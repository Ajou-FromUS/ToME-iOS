//
//  UIViewController+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIViewController {
    
    /**
     - Description: 화면 터치시 작성 종료
     */
    /// 화면 터치시 작성 종료하는 메서드
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     - Description: 화면 터치시 키보드 내리는 Extension
     */
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// tabBar 숨기기
    func hideTabBar(wantsToHide: Bool) {
        self.tabBarController?.tabBar.isHidden = wantsToHide
    }
}

