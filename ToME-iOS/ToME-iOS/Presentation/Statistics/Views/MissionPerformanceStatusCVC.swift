//
//  MissionPerformanceStatusCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then

final class MissionPerformanceStatusCVC: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let missionPerformanceStatusLabel = UILabel().then {
        $0.text = "미션 수행 현황"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var missionPerformanceStatusImage = UIImageView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension MissionPerformanceStatusCVC {
    private func setUI() {
        self.backgroundColor = .white
        self.missionPerformanceStatusImage.backgroundColor = .disabled2
    }
    
    private func setLayout() {
        self.addSubviews(missionPerformanceStatusLabel, missionPerformanceStatusImage)
        
        missionPerformanceStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(27)
        }
        
        missionPerformanceStatusImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(155)
            make.width.equalTo(206)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
