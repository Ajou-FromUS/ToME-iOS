//
//  ToAnimationManager.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

class ToAnimationManager {
    static func createFloatingAnimation() -> CABasicAnimation {
       let floatingAnimation = CABasicAnimation(keyPath: "transform.translation.y")
       floatingAnimation.duration = 1 // 애니메이션 기간 (초)
       floatingAnimation.fromValue = 0 // 시작 위치
       floatingAnimation.toValue = 7 // 위로 7 포인트 이동
       floatingAnimation.autoreverses = true // 애니메이션 후에 역방향으로 반복
       floatingAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // 애니메이션 타이밍 함수 설정
       floatingAnimation.repeatCount = .greatestFiniteMagnitude // 무한 반복
       return floatingAnimation
    }
}
