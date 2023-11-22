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
    
    let userName = "몽이"
    
    var didSelectMonthButton: (() -> Void)?
    
    private let todayString = ToMETimeFormatter.getYearAndMonthToString(date: Date())
    
    private let monthString = ToMETimeFormatter.getMonthToString(date: Date())
        
    // MARK: - UI Components
    
    private let horizontalDevidedView = UIView()
    
    private lazy var titleLabel = UILabel().then {
        $0.text = self.todayString
        $0.textColor = .font1
        $0.font = .subTitle2
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "티오가 \(userName)의 \(monthString)월을 분석했어요."
        $0.textColor = .font1
        $0.font = UIFont.font(.leeSeoyun, ofSize: 12)
    }
    
    private let selectMonthButton = UIButton().then {
        $0.setImage(ImageLiterals.mypageIcToggle, for: .normal)
    }
    
    private let toImageView = UIImageView().then {
        $0.image = ImageLiterals.statisticsToImg
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
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
        didSelectMonthButton?()
    }
}

// MARK: - Methods

extension SelectMonthCVC {
    private func setAddTarget() {
        self.selectMonthButton.addTarget(self, action: #selector(selectMonthButtonDidTap), for: .touchUpInside)
    }
    
    func setTitleLabel(year: String, month: String) {
        self.titleLabel.text = "\(year)년 \(month)월"
        self.subTitleLabel.text = "티오가 \(userName)의 \(month)월을 분석했어요."
    }
}
// MARK: - UI & Layout

extension SelectMonthCVC {
    private func setUI() {
        self.backgroundColor = .white
        self.horizontalDevidedView.backgroundColor = .disabled2
    }
    
    private func setLayout() {
        contentView.addSubviews(horizontalDevidedView, titleLabel, subTitleLabel, toImageView, selectMonthButton)
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23)
            make.leading.equalToSuperview().inset(27)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(27)
        }
        
        toImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(119)
            make.height.equalTo(76)
        }
        
        selectMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.leading.equalTo(titleLabel.snp.trailing).offset(11)
        }
    }
}
