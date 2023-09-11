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
}

final class CustomPopUpVC: UIViewController {
    
    // MARK: - Properties

    private let missionDataArray = ["몽이랑 놀기", "치킨먹기", "졸려", "테일러 스위프트"]

    // MARK: - UI Components
    
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
   
    // MARK: - initialization
    
    init(type: popUpType) {
        super.init(nibName: nil, bundle: nil)
        setLayout(type)
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
        setBlurEffect()
    }
    
    private func setLayout(_ type: popUpType) {
        view.addSubviews(containerView, popUpCloseButton)
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(321)
            make.height.equalTo(554)
        }
        
        popUpCloseButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(20)
            make.trailing.equalTo(containerView.snp.trailing).inset(15)
            make.width.height.equalTo(9)
        }
        
        switch type {
        case .todaysMission:
            setTodaysMissionLayout()
        }
    }
    
    private func setTodaysMissionLayout() {
        self.titleLabel.text = "오늘의 미션"
        self.subTitleLabel.text = "티오의 성장까지"
        
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
    
    private func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
    }
}
