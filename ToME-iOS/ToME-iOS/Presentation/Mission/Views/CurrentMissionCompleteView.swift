//
//  CurrentMissionCompleteView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

import SnapKit
import Then

final class CurrentMissionCompleteView: UIView {

    // MARK: - UI & Layout
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘의 미션 현황"
        $0.font = .body2
        $0.textColor = .font1
    }
    
    private let firstMissionImageView = UIImageView()
    private let secondMissionImageView = UIImageView()
    private let thirdMissionImageView = UIImageView()

    private lazy var missionStackView = UIStackView(arrangedSubviews: [firstMissionImageView,
                                                                  secondMissionImageView,
                                                                  thirdMissionImageView]).then {
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }
    
    // MARK: - Initialize

    public init(numberOfCompleteMission: Int) {
        super.init(frame: .zero)
        setUI(numberOfCompleteMission)
        setLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CurrentMissionCompleteView {
    /// 완성 미션 개수 변경
    @discardableResult
    public func changeNumberOfCompleteMission(_ numberOfCompleteMission: Int) -> Self {
        setUI(numberOfCompleteMission)
        // 레이아웃 업데이트를 위해 호출
        setNeedsLayout()
        layoutIfNeeded()
        return self
    }
}

// MARK: - UI & Layout

extension CurrentMissionCompleteView {
    private func setUI(_ numberOfCompleteMission: Int) {
        for i in 0..<3 {
            let image = i < numberOfCompleteMission ? ImageLiterals.missionProgressFill : ImageLiterals.missionProgress
            let imageView = [firstMissionImageView, secondMissionImageView, thirdMissionImageView][i]
            imageView.image = image
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, missionStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        for imageView in [firstMissionImageView, secondMissionImageView, thirdMissionImageView] {
            imageView.snp.makeConstraints { make in
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
        }
        
        missionStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
