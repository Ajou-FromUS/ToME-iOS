//
//  MissionView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import UIKit

import SnapKit
import Then

final class MissionView: UIView {
    
    // MARK: - UI Components
    
    private let missionLabel = UILabel().then {
        $0.font = .tabbar
        $0.textColor = .font1
    }
    
    private let dividedLineView = UIView()
    
    private let missionCheckButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.homeImgTodaysComplete, for: .normal)
        $0.setImage(ImageLiterals.homeImgTodaysCompleteFill, for: .disabled)
    }

    // MARK: - Initialize

    public init(mission: String) {
        super.init(frame: .zero)
        self.setUI()
        self.setLayout(mission)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension MissionView {
    private func setUI() {
        self.dividedLineView.backgroundColor = .disabled2
    }
    
    private func setLayout(_ mission: String) {
        self.missionLabel.text = mission
        
        self.addSubviews(missionLabel, missionCheckButton, dividedLineView)
        
        missionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        missionCheckButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        dividedLineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
