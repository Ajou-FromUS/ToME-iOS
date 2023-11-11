//
//  BubbleView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/3/23.
//

import UIKit

import SnapKit
import Then

@frozen
enum HomeBubbleType {
    case talkingWithTO
    case todaysMission
}

final class BubbleView: UIView {
    
    // MARK: - Properties

    var characterImageViewHeight = Int()
    var characterImageViewWidth = Int()
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .newBody3
        $0.textColor = .sub3
    }
    
    private let characterImageView = UIImageView()
    
    private let bubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.homeBtnBubble
    }
    
    // MARK: - Initialize

    public init(type: HomeBubbleType) {
        super.init(frame: .zero)
        setLayout(type)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension BubbleView {
    private func setLayout(_ type: HomeBubbleType) {
        switch type {
        case .talkingWithTO:
            self.titleLabel.text = "티오랑\n대화하기"
            setTitleLabel()
            self.characterImageView.image = ImageLiterals.homeIcTalking
            self.characterImageViewWidth = 43
            self.characterImageViewHeight = 25
        case .todaysMission:
            self.titleLabel.text = "오늘의 미션\n확인하기"
            setTitleLabel()
            self.characterImageView.image = ImageLiterals.homeIcMissionFill
            self.characterImageViewWidth = 33
            self.characterImageViewHeight = 28
        }
        
        self.addSubviews(bubbleImageView, characterImageView, titleLabel)
        
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.characterImageViewWidth)
            make.height.equalTo(self.characterImageViewHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func setTitleLabel() {
        self.titleLabel.setLineSpacing(lineSpacing: 3)
        self.titleLabel.textAlignment = .center
    }
}
