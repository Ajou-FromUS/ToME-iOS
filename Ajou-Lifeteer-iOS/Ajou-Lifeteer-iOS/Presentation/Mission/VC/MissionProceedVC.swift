//
//  MissionProceedVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/7/23.
//

import UIKit

import SnapKit
import Then

final class MissionProceedVC: UIViewController {
    
    // MARK: - Properties
    
    var missionType = Int()
    
    let decibelManager = ToMEDecibelMananger()
        
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
    private let middleLabel = UILabel().then {
        $0.text = "오늘의 미션을 수행해 보세요."
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.disabled2.cgColor
    }
    
    private let missionImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
    }
    
    private let missionTypeLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .font3
    }
    
    private let horizontalDevidedView = UIView()
    
    var missionTitleLabel = UILabel().then {
        $0.font = .newBody2
        $0.textColor = .font1
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
        setLayout()
        // 데시벨 측정 시작
        decibelManager.startMonitoringDecibels()
    }
}

// MARK: - Methods

extension MissionProceedVC {
    private func setData() {
        if missionType == 1 {
            self.missionTypeLabel.text = "데시벨 미션"
            self.missionImageView.image = ImageLiterals.missionImgDecibel
        } else {
            self.missionTypeLabel.text = "텍스트 미션"
            self.missionImageView.image = ImageLiterals.missionImgText
        }
    }
}

// MARK: - UI & Layout

extension MissionProceedVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        self.containerView.backgroundColor = .disabled2.withAlphaComponent(0.6)
        self.horizontalDevidedView.backgroundColor = .font3
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, middleLabel, containerView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        middleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(180)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.top.equalTo(middleLabel.snp.bottom).offset(31)
        }
        
        containerView.addSubviews(missionImageView, missionTypeLabel, horizontalDevidedView, missionTitleLabel)
        
        missionImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(21)
            make.width.height.equalTo(67)
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(missionImageView.snp.top).inset(4)
            make.leading.equalTo(missionImageView.snp.trailing).offset(15)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(missionTypeLabel.snp.bottom).offset(7)
            make.leading.equalTo(missionTypeLabel.snp.leading)
            make.width.equalTo(97)
            make.height.equalTo(0.5)
        }
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(10)
            make.leading.equalTo(missionTypeLabel.snp.leading)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(missionTitleLabel.snp.bottom).offset(20)
        }
    }
}
