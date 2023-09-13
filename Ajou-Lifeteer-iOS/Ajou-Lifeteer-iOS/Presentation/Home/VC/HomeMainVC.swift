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
    
    private lazy var levelContainerView = UIView().then {
        $0.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchUpLevelContainerView))
        $0.addGestureRecognizer(tap)
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
    
    private let characterImageView = UIImageView()
    
    private lazy var messageBubbleView = CustomMessageBubbleView(message: "오늘은\n무슨 일 있었어?", type: .onlyMessage)
    
    private lazy var emojiBubbleView = CustomMessageBubbleView(message: "\u{1F618}", type: .emoji)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        setUI()
        setLayout()
        setAddTarget()
    }
}

// MARK: - @objc Function

extension HomeMainVC {
    @objc private func touchUpLevelContainerView() {
        pushToCharacterLevelPopUpVC()
    }
}
// MARK: - Methods

extension HomeMainVC {
    private func setAddTarget() {

    }
    
    private func pushToCharacterLevelPopUpVC() {
        let characterLevelPopUpVC = CustomPopUpVC(type: .characterlevel,
                                                  title: "티오의 레벨",
                                                  subTitle: "미션을 열심히 수행하여 티오를 키워보세요!",
                                                  level: nil,
                                                  levelName: "응애")
        characterLevelPopUpVC.modalPresentationStyle = .overFullScreen
        self.present(characterLevelPopUpVC, animated: false)
        
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
        view.addSubviews(naviBar, levelContainerView, menuButton, snackLabel, snackImageView, characterImageView, messageBubbleView, emojiBubbleView)
        
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
        
        messageBubbleView.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.leading).offset(-33)
            make.top.equalTo(characterImageView.snp.top).offset(-38)
            make.width.equalTo(95)
            make.height.equalTo(50)
        }
        
        emojiBubbleView.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).inset(10)
            make.top.equalTo(characterImageView.snp.top).inset(72)
            make.width.height.equalTo(47)
        }
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
}
