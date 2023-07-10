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
    case backButton // 뒤로가기 버튼
    case backButtonWithTitle // 뒤로가기 버튼 + 중앙 타이틀
    case menuButtonWithTitle // 메뉴 버튼 + 중앙 타이틀
    case menuButtonWithBI // 메뉴 버튼 + BI
    case buttonsWithTitle // 뒤로가기 버튼 + 중앙 타이틀 + 메뉴 버튼
    case onlyBI // BI만 존재
    case onlyTitle // Title만 존재
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
    private let menuButton = UIButton()
    private let mindSetBIImageView = UIImageView()
    
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
        self.menuButton.addTarget(self, action: #selector(pushToUserMenuMainVC), for: .touchUpInside)
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
    
    @discardableResult
    func resetMenuButtonAction(_ closure: (() -> Void)? = nil) -> Self {
        self.menuButtonClosure = closure
        self.menuButton.removeTarget(self, action: nil, for: .touchUpInside)
        if closure != nil {
            self.menuButton.addTarget(self, action: #selector(menuButtonDidTap), for: .touchUpInside)
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
    
    @objc private func pushToUserMenuMainVC() {
        let userMenuMainVC = UserMenuMainVC()
        self.vc?.navigationController?.pushViewController(userMenuMainVC, animated: true)
    }
    
    @objc private func backButtonDidTap() {
        self.backButtonClosure?()
    }
    
    @objc private func menuButtonDidTap() {
        self.menuButtonClosure?()
    }
}

// MARK: - UI & Layout

extension CustomNavigationBar {
    private func setTitleUI() {
        centerTitleLabel.font = .b0
        centerTitleLabel.textColor = .mainBlack
        centerTitleLabel.isHidden = false
    }
    
    private func setUI(_ type: NaviType) {
        self.naviType = type
        self.backgroundColor = .mainBackground
        
        switch type {
        case .backButton:
            backButton.isHidden = false
            backButton.setImage(ImageLiterals.icBack, for: .normal)
        case .backButtonWithTitle:
            setTitleUI()
            backButton.setImage(ImageLiterals.icBack, for: .normal)
        case .menuButtonWithTitle:
            setTitleUI()
            menuButton.setImage(ImageLiterals.icMenu, for: .normal)
        case .menuButtonWithBI:
            menuButton.setImage(ImageLiterals.icMenu, for: .normal)
            mindSetBIImageView.image = ImageLiterals.icMindsetBI
        case .buttonsWithTitle:
            setTitleUI()
            menuButton.setImage(ImageLiterals.icMenu, for: .normal)
            backButton.setImage(ImageLiterals.icBack, for: .normal)
        case .onlyBI:
            mindSetBIImageView.image = ImageLiterals.icMindsetBI
        case .onlyTitle:
            setTitleUI()
        }
    }
    
    private func setLayout(_ type: NaviType) {
        switch type {
        case .backButton:
            setBackButtonLayout()
        case .backButtonWithTitle:
            setBackButtonWithTitleLayout()
        case .menuButtonWithTitle:
            setMenuButtonWithTitleLayout()
        case .menuButtonWithBI:
            setMenuButtonWithBILayout()
        case .buttonsWithTitle:
            setButtonsWithTitleLayout()
        case .onlyBI:
            setOnlyBILayout()
        case .onlyTitle:
            setOnlyTitleLayout()
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
    
    private func setMenuButtonWithTitleLayout() {
        self.addSubviews(menuButton, centerTitleLabel)
        
        menuButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(24)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setMenuButtonWithBILayout() {
        self.addSubviews(menuButton, mindSetBIImageView)
        
        menuButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(24)
        }
        
        mindSetBIImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(31)
            make.width.equalTo(43)
        }
    }
    
    private func setButtonsWithTitleLayout() {
        self.addSubviews(backButton, menuButton, mindSetBIImageView, centerTitleLabel)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
        
        menuButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(24)
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
}

