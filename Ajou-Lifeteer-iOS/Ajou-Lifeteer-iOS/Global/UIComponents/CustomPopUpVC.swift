//
//  CustomPopUpVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import UIKit

import SnapKit
import Then

@frozen
enum popUpType {
    case todaysMission
    case characterlevel
    case toGrowCharacter
}

final class CustomPopUpVC: UIViewController {
    
    // MARK: - Properties

    private let missionDataArray = ["몽이랑 놀기", "치킨먹기", "졸려", "테일러 스위프트"]

    // MARK: - UI Components
    
    private let blurEffect = UIBlurEffect(style: .light)
    
    private lazy var visualEffectView = UIVisualEffectView(effect: blurEffect).then {
        $0.frame = self.view.frame
    }
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.disabled1.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .title3
        $0.textColor = .font1
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .tabbar
        $0.textColor = .font3
    }
    
    private let shownLevelProgressLabel = UILabel().then {
        $0.font = .tabbar
        $0.textColor = .font3
    }
    
    private let levelNameLabel = UILabel().then {
        $0.font = .title4
        $0.textColor = .font1
    }
    
    private let explainLevelLabel = UILabel().then {
        $0.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        let attributedText = NSAttributedString(
            string: "티오의 가장 어린 모습입니다.\n쑥스러움이 많아 혼잣말을 자주 해요.",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.body2,
                NSAttributedString.Key.foregroundColor: UIColor.font1
            ]
        )
        $0.attributedText = attributedText
    }
    
    private lazy var progressBar = CustomProgressView(progress: 0.3)
    
    private lazy var messageBubbleView = CustomMessageBubbleView(message: "오늘 하루도\n파이팅!", type: .onlyMessage)
    
    private let characterImageView = UIImageView()
    
    private let popUpCloseButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.homeIcPopupClose, for: .normal)
    }
    
    private let missionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let dividedView = UIView()
    
    private let shareButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.homeBtnShare, for: .normal)
    }
           
    // MARK: - initialization
    
    init(type: popUpType, title: String, subTitle: String, level: Int?, levelName: String?) {
        super.init(nibName: nil, bundle: nil)
        setLayout(type, title, subTitle, level, levelName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAddTarget()
    }
}

// MARK: - Methods

extension CustomPopUpVC {
    private func setAddTarget() {
        self.popUpCloseButton.addTarget(self, action: #selector(popUpCloseButtonDidTap), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.visualEffectView {
            dismiss(animated: false)
        }
    }
}

// MARK: - @objc Function

extension CustomPopUpVC {
    @objc private func popUpCloseButtonDidTap() {
        dismiss(animated: false)
    }
}

// MARK: - UI & Layout

extension CustomPopUpVC {
    private func setUI() {
        self.containerView.backgroundColor = .white
        self.characterImageView.backgroundColor = .mainColor
        self.dividedView.backgroundColor = .disabled1
    }
    
    private func setLayout(_ type: popUpType, _ title: String, _ subTitle: String,
                           _ level: Int?, _ levelName: String?) {
        view.addSubviews(visualEffectView, containerView, popUpCloseButton)
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        popUpCloseButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(20)
            make.trailing.equalTo(containerView.snp.trailing).inset(15)
            make.width.height.equalTo(9)
        }
        
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        if let level = level {
            self.shownLevelProgressLabel.text = "티오가 \(level)만큼 성장했어요."
        }
        
        if let levelName = levelName {
            self.levelNameLabel.text = "Lv. \(levelName)"
        }

        switch type {
        case .todaysMission:
            setTodaysMissionLayout()
        case .characterlevel:
            setCharacterLevelLayout()
        case .toGrowCharacter:
            setCheckCharacterLevelLayout()
        }
    }
    
    private func setTodaysMissionLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(554)
        }
        
        containerView.addSubviews(titleLabel, subTitleLabel, characterImageView, messageBubbleView, progressBar, missionStackView)
        
        for missionTitle in missionDataArray {
            let missionView = MissionView(mission: missionTitle)
            missionView.translatesAutoresizingMaskIntoConstraints = false
            missionView.snp.makeConstraints { make in
                make.height.equalTo(46)
            }
            missionStackView.addArrangedSubview(missionView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(123)
            make.height.equalTo(188)
        }
        
        messageBubbleView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.top).inset(34)
            make.leading.equalTo(characterImageView.snp.leading).offset(74)
            make.width.equalTo(95)
            make.height.equalTo(50)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(31)
            make.centerX.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(49)
            make.height.equalTo(8)
        }
        
        missionStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(17)
            make.height.equalTo(186)
        }
    }
     
    private func setCharacterLevelLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(554)
        }
        
        containerView.addSubviews(titleLabel, characterImageView, levelNameLabel,
                                  explainLevelLabel, shareButton, dividedView, progressBar, subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(53)
            make.centerX.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(99)
            make.height.equalTo(188)
        }
        
        levelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        explainLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(levelNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(explainLevelLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(21)
            make.height.equalTo(23)
        }
        
        dividedView.snp.makeConstraints { make in
            make.top.equalTo(shareButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(38)
            make.height.equalTo(0.5)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(dividedView.snp.bottom).offset(39)
            make.leading.trailing.equalToSuperview().inset(44)
            make.height.equalTo(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setCheckCharacterLevelLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(427)
        }
        
        containerView.addSubviews(titleLabel, subTitleLabel, characterImageView, messageBubbleView, shownLevelProgressLabel, progressBar)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.width.equalTo(123)
            make.height.equalTo(188)
            make.centerX.equalToSuperview()
        }
        
        messageBubbleView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.top).inset(16)
            make.trailing.equalTo(characterImageView.snp.trailing).offset(80)
            make.width.equalTo(95)
            make.height.equalTo(50)
        }
        
        shownLevelProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(shownLevelProgressLabel.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(44)
            make.height.equalTo(8)
        }
    }
}
