//
//  MonthlyKeywordAnalysisCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import Then
import SnapKit

final class MonthlyKeywordAnalysisCVC: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let monthlyKeywordLabel = UILabel().then {
        $0.text = "월간 키워드 분석"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var monthlyKeywordImage = UIImageView()
    
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

// MARK: - Methods

extension MonthlyKeywordAnalysisCVC {
    func setData(image: String) {
        self.monthlyKeywordImage.setImage(with: image)
    }
}

// MARK: - UI & Layout

extension MonthlyKeywordAnalysisCVC {
    private func setUI() {
        self.backgroundColor = .white
        self.monthlyKeywordImage.backgroundColor = .disabled2
    }
    
    private func setLayout() {
        self.addSubviews(monthlyKeywordLabel, monthlyKeywordImage)
        
        monthlyKeywordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(27)
        }
        
        monthlyKeywordImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(155)
            make.width.equalTo(206)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
