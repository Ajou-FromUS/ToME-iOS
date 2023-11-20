//
//  CustomBlur.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/19/23.
//

import UIKit

import SnapKit
import Then
import Lottie

class CustomBlur {
    static let shared = CustomBlur()

    private let blurEffect = UIBlurEffect(style: .extraLight)

    // LottieAnimationView에 블러를 추가하는 메서드
    func addBlurEffect(to view: UIView) {
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(visualEffectView)
    }

    // LottieAnimationView에 블러 강도를 조절하는 메서드
    func setBlurIntensity(to view: UIView, intensity: CGFloat) {
        for subview in view.subviews {
            if let visualEffectView = subview as? UIVisualEffectView {
                visualEffectView.effect = UIBlurEffect(style: .light)
                visualEffectView.alpha = intensity
            }
        }
    }
}
