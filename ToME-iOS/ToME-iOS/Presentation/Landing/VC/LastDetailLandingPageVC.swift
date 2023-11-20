//
//  LastDetailLandingPageVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/27.
//

import UIKit

import SnapKit
import Then
import Lottie

final class LastDetailLandingPageVC: UIViewController {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "서두르지 마세요!"
        $0.textColor = .mainColor
        $0.font = .body2
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "언제든 괜찮으니 마음을 정리하고 싶을 때 \n찾아와 주세요. 기다리고 있을게요 :)"
        $0.numberOfLines = 2
        let attrString = NSMutableAttributedString(string: $0.text!, attributes: [.font: UIFont.body1, .foregroundColor: UIColor.disabled1])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
    }

    private let mainAnimationView: LottieAnimationView = .init(name: "LandingDontHurry")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAnimation()
    }
}

// MARK: - UI & Layout

extension LastDetailLandingPageVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(subTitleLabel, titleLabel, mainAnimationView)
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-13)
            make.centerX.equalToSuperview()
        }
        
        mainAnimationView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(-35)
            make.trailing.equalToSuperview().offset(35)
            make.height.equalTo(mainAnimationView.snp.width).multipliedBy(0.7)
        }
    }
    
    private func setAnimation() {
        mainAnimationView.play()
        mainAnimationView.loopMode = .loop
    }
}
