//
//  HomeMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class HomeMainVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .home).setUserName("몽이누나")
    
    private let levelContainerView = UIView().then {
        $0.layer.cornerRadius = 8
    }
    
    private let levelLabel = UILabel().then {
        $0.text = "Lv. 응애"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private let levelIconLabel = UILabel().then {
        $0.text = "\u{1F37C}"
        $0.font = .subTitle2
    }
    
    private lazy var levelProgressBar = CustomProgressView(progress: 0.3)
    
    private let menuButton = UIButton().then {
        $0.setImage(ImageLiterals.homeIcMenu, for: .normal)
    }
    
    private let snackLabel = UILabel().then {
        $0.text = "티오의 과자"
        $0.font = .snack
        $0.textColor = .snack
    }
    
    private let snackImageView = UIImageView().then {
        $0.image = ImageLiterals.homeIcMenuSnack
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center

        let attributedText = NSAttributedString(
            string: "오늘은\n 무슨 일 있었어?",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.body3,
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
        )
        
        $0.attributedText = attributedText
    }
    
    private let messageBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgSpeachBubble
    }
    
    private let characterImageView = UIImageView()
    
    private let emojiBubbleLabel = UILabel().then {
        $0.text = "\u{1F618}"
        $0.font = .title1
    }
    
    private let emojiBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgEmoSpeachBubble
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension HomeMainVC {
    private func setUI() {
        view.backgroundColor = .black
        levelContainerView.backgroundColor = .white.withAlphaComponent(0.6)
        characterImageView.backgroundColor = .mainColor
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, levelContainerView, menuButton, snackLabel, snackImageView, characterImageView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(179)
        }
        
        levelContainerView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.width.equalTo(136)
            make.height.equalTo(51)
        }
        
        setLevelContainerViewLayout()
        
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
            make.width.height.equalTo(35)
        }
        
        snackLabel.snp.makeConstraints { make in
            make.top.equalTo(levelContainerView.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(27)
        }
        
        snackImageView.snp.makeConstraints { make in
            make.top.equalTo(snackLabel.snp.bottom).offset(5)
            make.leading.equalTo(snackLabel.snp.leading)
            make.width.equalTo(43)
            make.height.equalTo(55)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(169)
            make.width.equalTo(170)
            make.height.equalTo(260)
        }
        
        setCharacterMessagesLayout()
    }
    
    private func setLevelContainerViewLayout() {
        levelContainerView.addSubviews(levelLabel, levelIconLabel, levelProgressBar)
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7)
            make.leading.equalToSuperview().inset(16)
        }
        
        levelIconLabel.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.top)
            make.trailing.equalToSuperview().inset(17)
        }
        
        levelProgressBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(8)
        }
    }
    
    private func setCharacterMessagesLayout() {
        characterImageView.addSubviews(messageBubbleImageView, messageLabel, emojiBubbleImageView, emojiBubbleLabel)
        
        messageBubbleImageView.snp.makeConstraints { make in
            make.bottom.equalTo(characterImageView.snp.top).inset(8)
            make.trailing.equalTo(characterImageView.snp.leading).inset(54)
            make.width.equalTo(95)
            make.height.equalTo(50)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(messageBubbleImageView)
        }
        
        emojiBubbleImageView.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).inset(10)
            make.top.equalToSuperview().inset(72)
            make.width.height.equalTo(47)
        }
        
        emojiBubbleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(emojiBubbleImageView)
        }
    }
}
