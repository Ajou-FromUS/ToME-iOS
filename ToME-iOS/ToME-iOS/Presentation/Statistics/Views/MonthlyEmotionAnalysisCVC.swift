//
//  MonthlyEmotionAnalysisCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then

final class MonthlyEmotionAnalysisCVC: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let monthlyEmotionLabel = UILabel().then {
        $0.text = "월간 감정 분석"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var monthlyEmotionImage = UIImageView()
    
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

extension MonthlyEmotionAnalysisCVC {
    private func setUI() {
        self.backgroundColor = .white
        self.monthlyEmotionImage.backgroundColor = .disabled2
    }
    
    private func setLayout() {
        self.addSubviews(monthlyEmotionLabel, monthlyEmotionImage)
        
        monthlyEmotionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(27)
        }
        
        monthlyEmotionImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(155)
            make.width.equalTo(206)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
