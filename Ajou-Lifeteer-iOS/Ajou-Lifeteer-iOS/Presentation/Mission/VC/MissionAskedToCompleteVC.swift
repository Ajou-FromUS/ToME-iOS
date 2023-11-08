//
//  MissionAskedToCompleteVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/7/23.
//

import UIKit

import SnapKit
import Then

final class MissionAskedToCompleteVC: UIViewController {
    
    // MARK: - Properties

    private var photoManager: ToMEPhotoManager?
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
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
    
    private let missionTitleLabel = UILabel().then {
        $0.font = .newBody2
        $0.textColor = .font1
    }
    
    private lazy var startMissionButton = CustomButton(title: "티오에게 보여주기", type: .fillWithBlueAndImage)
                                                        .setImage(image: ImageLiterals.toBtnImage, disabledImage: nil)
    
    private lazy var backButton = CustomButton(title: "사진 다시 선택하기", type: .fillWithGreyAndImage)
                                                        .setImage(image: ImageLiterals.gallaryBtnImage, disabledImage: nil)
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("d")
        setUI()
        setLayout()
        // PhotoManager 초기화
        photoManager = ToMEPhotoManager(vc: self)
    }
}

// MARK: - UI & Layout

extension MissionAskedToCompleteVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        self.containerView.backgroundColor = .disabled2.withAlphaComponent(0.6)
        self.horizontalDevidedView.backgroundColor = .font3
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, containerView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        setContainerViewLayout()
    }
    
    private func setContainerViewLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(170)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
        }
        
        containerView.addSubviews(missionImageView, missionTypeLabel, horizontalDevidedView, missionTitleLabel)
        
        missionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(missionImageView.snp.width).multipliedBy(0.7)
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(missionImageView.snp.leading)
            make.top.equalTo(missionImageView.snp.bottom).offset(14)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(missionTypeLabel.snp.bottom).offset(8)
            make.leading.equalTo(missionImageView.snp.leading)
            make.width.equalTo(97)
            make.height.equalTo(0.5)
        }
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(10)
            make.leading.equalTo(missionImageView.snp.leading)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(missionTitleLabel.snp.bottom).offset(20)
        }
    }
}
