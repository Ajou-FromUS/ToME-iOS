//
//  CustomMessageBubbleView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import UIKit

import SnapKit
import Then

@frozen
enum BubbleType {
    case onlyMessage
    case emoji
    case rectangular
}

final class CustomMessageBubbleView: UIView {
    
    // MARK: - UI Components
    
    private let messageBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgSpeachBubble
    }
    
    private let emojiBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgEmoSpeachBubble
    }
    
    private let rectangularBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.archiveImgMessage
    }
    
    private let emojiBubbleLabel = UILabel().then {
        $0.font = .title1
    }
    
    private let rectangularBubbleLabel = UILabel().then {
        $0.font = .title3
        $0.textColor = .font1
    }
    
    private let messageLabel = UILabel()
    
    // MARK: - Initialize
    
    init(message: String, type: BubbleType) {
        super.init(frame: .zero)
        self.setUI(message, type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension CustomMessageBubbleView {
    private func setUI(_ message: String, _ type: BubbleType) {
        switch type {
        case .onlyMessage:
            setMessageLabel(message)
            
            self.addSubviews(messageBubbleImageView, messageLabel)
            
            messageBubbleImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            messageLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        case .emoji:
            self.emojiBubbleLabel.text = message
            
            self.addSubviews(emojiBubbleImageView, emojiBubbleLabel)
            
            emojiBubbleImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            emojiBubbleLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        case .rectangular:
            self.rectangularBubbleLabel.text = message
            
            self.addSubviews(rectangularBubbleImageView, rectangularBubbleLabel)
            
            rectangularBubbleImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            rectangularBubbleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(5)
            }
        }
    }
    
    private func setMessageLabel(_ message: String) {
        self.messageLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center

        let attributedText = NSAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.body3,
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
        )
        
        self.messageLabel.attributedText = attributedText
    }
}
