//
//  FirstDetailLandingPageVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/27.
//

import UIKit

import SnapKit
import Then

final class FirstDetailLandingPageVC: UIViewController {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "마음짓기"
        $0.textColor = .mainBlack
        $0.font = .h0
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "회고록, 너무 어렵게 느껴지시나요?\n 어렵지 않게 백문백답 형식으로 작성해보아요."
        $0.numberOfLines = 2
        let attrString = NSMutableAttributedString(string: $0.text!, attributes: [.font: UIFont.b2, .foregroundColor: UIColor.disabledText])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
    }

    private let landingPageImageView = UIImageView().then {
        $0.image = ImageLiterals.imgLandingPage1
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension FirstDetailLandingPageVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(landingPageImageView, subTitleLabel, titleLabel)
        
        landingPageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().inset(85)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(landingPageImageView.snp.width).multipliedBy(1.4)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-13)
            make.centerX.equalToSuperview()
        }

    }
}

