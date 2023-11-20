//
//  SettingTableViewCell.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/20/23.
//

import UIKit

import SnapKit
import Then

final class SettingTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.disabled2.cgColor
    }
    
    private let settingTitleLabel = UILabel().then {
        $0.font = .body1
        $0.textColor = .font1
    }
    
    private let horizontalDevidedView = UIView()
    
    private let missionTitleLabel = UILabel().then {
        $0.font = .newBody2
        $0.textColor = .font1
    }
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension SettingTableViewCell {
    func setData(title: String) {
        self.settingTitleLabel.text = title
    }
}

// MARK: - UI & Layout

extension SettingTableViewCell {
    private func setUI() {
        self.containerView.backgroundColor = .font4
    }
    
    private func setLayout() {
        self.addSubviews(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        containerView.addSubview(settingTitleLabel)
        
        settingTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(32)
        }
    }
}
