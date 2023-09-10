//
//  CustomNavigationBar.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

@frozen
enum NaviType {
    /// 나중에 필요없는 코드 삭제할 것!!!!!!
    case backButton // 뒤로가기 버튼
    case backButtonWithTitle // 뒤로가기 버튼 + 중앙 타이틀
    case buttonsWithTitle // 뒤로가기 버튼 + 중앙 타이틀
    case onlyBI // BI만 존재
    case onlyTitle // Title만 존재
    
    case home // 홈에 존재하는 네비바
}

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    private var naviType: NaviType!
    private var vc: UIViewController?
    private var backButtonClosure: (() -> Void)?
    private var menuButtonClosure: (() -> Void)?

    // MARK: - UI Components
    
    private let centerTitleLabel = UILabel()
    private let backButton = UIButton()
    private let mindSetBIImageView = UIImageView()
    
    private let logoLabel = UILabel().then {
        $0.text = "ToME"
    }
    
    private let missionButton = UIButton()
    private let mypageButton = UIButton()
    
    // MARK: - initialization
    
    init(_ vc: UIViewController, type: NaviType) {
        super.init(frame: .zero)
        self.vc = vc
        self.setUI(type)
        self.setLayout(type)
        self.setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomNavigationBar {
    private func setAddTarget() {
        self.backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
    }
    
    @discardableResult
    func setUserName(_ name: String) -> Self {
        self.centerTitleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6

        let attributedText = NSAttributedString(
            string: "\(name)님,\n어서오세요!",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.title1,
                NSAttributedString.Key.foregroundColor: UIColor.font1
            ]
        )
        
        self.centerTitleLabel.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func setTitle(_ title: String) -> Self {
        self.centerTitleLabel.text = title
        return self
    }
    
    @discardableResult
    func resetBackButtonAction(_ closure: (() -> Void)? = nil) -> Self {
        self.backButtonClosure = closure
        self.backButton.removeTarget(self, action: nil, for: .touchUpInside)
        if closure != nil {
            self.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        } else {
            self.setAddTarget()
        }
        return self
    }
}

// MARK: - @objc Function

extension CustomNavigationBar {
    @objc private func popToPreviousVC() {
        self.vc?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonDidTap() {
        self.backButtonClosure?()
    }
}

// MARK: - UI & Layout

extension CustomNavigationBar {
    private func setTitleUI() {
        centerTitleLabel.font = .body1
        centerTitleLabel.textColor = .mainColor
        centerTitleLabel.isHidden = false
    }
    
    private func setHomeUI() {
        logoLabel.font = .logo
        logoLabel.textColor = .font1
        logoLabel.isHidden = false
        
        centerTitleLabel.font = .title1
        centerTitleLabel.textColor = .font1
        centerTitleLabel.textAlignment = .left
        centerTitleLabel.isHidden = false
        
        missionButton.setImage(ImageLiterals.homeBtnMission, for: .normal)
        mypageButton.setImage(ImageLiterals.homeBtnMypage, for: .normal)
    }
    
    private func setUI(_ type: NaviType) {
        self.naviType = type
        self.backgroundColor = .back1
        self.layer.cornerRadius = 15
        
        switch type {
        case .backButton:
            backButton.isHidden = false
            backButton.setImage(ImageLiterals.introIcCheck, for: .normal)
        case .backButtonWithTitle:
            setTitleUI()
            backButton.setImage(ImageLiterals.introIcCheck, for: .normal)
        case .buttonsWithTitle:
            setTitleUI()
            backButton.setImage(ImageLiterals.introIcCheck, for: .normal)
        case .onlyBI:
            mindSetBIImageView.image = ImageLiterals.introIcCheck
        case .onlyTitle:
            setTitleUI()
            
        case .home:
            setHomeUI()
        }
    }
    
    private func setLayout(_ type: NaviType) {
        switch type {
        case .backButton:
            setBackButtonLayout()
        case .backButtonWithTitle:
            setBackButtonWithTitleLayout()
        case .buttonsWithTitle:
            setButtonsWithTitleLayout()
        case .onlyBI:
            setOnlyBILayout()
        case .onlyTitle:
            setOnlyTitleLayout()
        case .home:
            setHomeLayout()
        }
    }
    
    private func setBackButtonLayout() {
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
    }
    
    private func setBackButtonWithTitleLayout() {
        self.addSubviews(backButton, centerTitleLabel)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setButtonsWithTitleLayout() {
        self.addSubviews(backButton, mindSetBIImageView, centerTitleLabel)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
        
        mindSetBIImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(31)
            make.width.equalTo(43)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setOnlyBILayout() {
        self.addSubview(mindSetBIImageView)
        
        mindSetBIImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(31)
            make.width.equalTo(43)
        }
    }
    
    private func setOnlyTitleLayout() {
        self.addSubview(centerTitleLabel)
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setHomeLayout() {
        self.addSubviews(logoLabel, centerTitleLabel, missionButton, mypageButton)
        
        centerTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(27)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(centerTitleLabel.snp.top).offset(-11)
            make.leading.equalTo(centerTitleLabel.snp.leading)
        }
        
        mypageButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(54)
            make.width.height.equalTo(32)
        }
        
        missionButton.snp.makeConstraints { make in
            make.trailing.equalTo(mypageButton.snp.leading).offset(-16)
            make.bottom.equalTo(mypageButton.snp.bottom)
            make.width.height.equalTo(32)
        }
    }
}
