//
//  AccountSettingView.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/21/23.
//

import UIKit

import SnapKit
import Then

final class AccountSettingView: UIView {
    
    // MARK: - UI Components

    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .font1
        $0.font = .body1
    }
    
    private let currentNicknameLabel = UILabel().then {
        $0.text = "몽이누나"
        $0.textColor = UIColor(hex: "#232323")
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    private let editNicknameButton = UIButton(type: .custom).then {
        $0.setTitle("닉네임 변경", for: .normal)
        $0.setTitleColor(.font4, for: .normal)
        $0.setBackgroundColor(.mainColor, for: .normal)
        $0.layer.cornerRadius = 3
        $0.titleLabel?.font = UIFont.font(.pretendardRegular, ofSize: 12)
    }
    
    private let horizontalDevidedView = UIView()
    
    private let logoutLabel = UILabel().then {
        $0.text = "로그아웃"
        $0.textColor = UIColor(hex: "#A1A1A1")
        $0.font = .body1
    }
    
    private let withdrawalLabel = UILabel().then {
        $0.text = "회원 탈퇴"
        $0.textColor = UIColor(hex: "#A1A1A1")
        $0.font = .body1
    }
    
    // MARK: - Initialize

    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension AccountSettingView {
    private func setUI() {
        self.backgroundColor = .clear
        self.horizontalDevidedView.backgroundColor = UIColor(hex: "#DCDCDC")
    }
    
    private func setLayout() {
        self.addSubviews(nicknameLabel, currentNicknameLabel, editNicknameButton,
                         horizontalDevidedView, logoutLabel, withdrawalLabel)
       
        editNicknameButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(32)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(editNicknameButton.snp.centerY)
            make.leading.equalToSuperview()
        }
        
        currentNicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(editNicknameButton.snp.centerY)
            make.trailing.equalTo(editNicknameButton.snp.leading).offset(-9)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(editNicknameButton.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        logoutLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(32)
            make.leading.equalToSuperview()
        }
        
        withdrawalLabel.snp.makeConstraints { make in
            make.top.equalTo(logoutLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview()
        }
    }
}
