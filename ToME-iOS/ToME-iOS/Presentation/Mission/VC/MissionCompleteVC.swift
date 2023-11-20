//
//  MissionAskedToCompleteVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/7/23.
//

import UIKit

import SnapKit
import Then
import Lottie

final class MissionCompleteVC: UIViewController {

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
    private let missionCompleteLottieView: LottieAnimationView = .init(name: "missionComplete")
    
    private let missionCompleteSubLabel = UILabel().then {
        $0.text = "오늘 하루도 수고 많았어요 :)"
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    private let missionCompleteTitleLabel = UILabel().then {
        $0.text = "오늘의 글쓰기 미션 완료"
        $0.font = .newBody1
        $0.textColor = .font1
    }
    
    private lazy var nextMissionButton = CustomButton(title: "다음 미션 수행하기", type: .fillWithBlueAndImage)
                                                        .setImage(image: ImageLiterals.toBtnImage, disabledImage: nil)
    
    private lazy var backToHomeButton = CustomButton(title: "홈으로 돌아가기", type: .fillWithGrey)
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        ToMEMusicManager.shared.playMusic(withTitle: "oneOfMissionComplete", loop: 0)
        setAnimation()
    }
}

// MARK: - @objc Function

extension MissionCompleteVC {
    @objc private func popToMissionVC() {
        // 이동하고자 하는 이전 페이지의 인덱스를 찾거나 해당 뷰 컨트롤러를 가져옵니다.
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count >= 4 {
                let previousViewController = viewControllers[viewControllers.count - 4]
                self.navigationController?.popToViewController(previousViewController, animated: false)
            }
        }
    }
    
    @objc private func popToHomeVC() {
        // 이동하고자 하는 이전 페이지의 인덱스를 찾거나 해당 뷰 컨트롤러를 가져옵니다.
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count >= 5 {
                let previousViewController = viewControllers[viewControllers.count - 5]
                self.navigationController?.popToViewController(previousViewController, animated: false)
            }
        }
    }
}

// MARK: - Methods

extension MissionCompleteVC {
    private func setAddTarget() {
        self.nextMissionButton.addTarget(self, action: #selector(popToMissionVC), for: .touchUpInside)
        self.backToHomeButton.addTarget(self, action: #selector(popToHomeVC), for: .touchUpInside)
    }
    
    private func setAnimation() {
        missionCompleteLottieView.play()
    }
}

// MARK: - UI & Layout

extension MissionCompleteVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        self.missionCompleteLottieView.backgroundColor = .clear
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, missionCompleteLottieView, missionCompleteSubLabel,
                         missionCompleteTitleLabel, nextMissionButton, backToHomeButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        missionCompleteLottieView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(113)
            make.width.height.equalTo(211)
            make.centerX.equalToSuperview()
        }
        
        missionCompleteSubLabel.snp.makeConstraints { make in
            make.top.equalTo(missionCompleteLottieView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        missionCompleteTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(missionCompleteSubLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        backToHomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
        
        nextMissionButton.snp.makeConstraints { make in
            make.bottom.equalTo(backToHomeButton.snp.top).offset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
    }
}
