//
//  SelectMonthCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then

final class SelectMonthCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    var didSelectMonthButton: (() -> Void)?
        
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "2023년 13월"
        $0.textColor = .font1
        $0.font = .subTitle2
    }
    
    private let selectMonthButton = UIButton().then {
        $0.setImage(ImageLiterals.mypageIcToggle, for: .normal)
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setAddTarget()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - @objc Function

extension SelectMonthCVC {
    @objc private func selectMonthButtonDidTap() {
        print("s")
        didSelectMonthButton?()
    }
}

// MARK: - Methods

extension SelectMonthCVC {
    private func setAddTarget() {
        self.selectMonthButton.addTarget(self, action: #selector(selectMonthButtonDidTap), for: .touchUpInside)
    }
}
// MARK: - UI & Layout

extension SelectMonthCVC {
    private func setLayout() {
        contentView.addSubviews(titleLabel, selectMonthButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23)
            make.leading.equalToSuperview().inset(27)
        }
        
        selectMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.leading.equalTo(titleLabel.snp.trailing).offset(11)
        }
    }
}
