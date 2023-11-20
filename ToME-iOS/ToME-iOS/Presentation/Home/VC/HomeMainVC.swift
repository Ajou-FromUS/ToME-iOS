//
//  HomeMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then
import Lottie

final class HomeMainVC: UIViewController {
    
    // MARK: - Properties

    var isTalkedWithTo: Bool = true
    
    // 햅틱 피드백 제너레이터
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .home).setUserName("세상에서제일귀여운몽이누나")
    
    private lazy var talkingWithToBubbleView = BubbleView(type: .talkingWithTO).then {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(talkingWithToBubbleViewDidTap))
        $0.addGestureRecognizer(tapGesture)
    }
    
    private lazy var todaysMissionBubbleView = BubbleView(type: .todaysMission).then {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(todaysMissionBubbleViewDidTap))
        $0.addGestureRecognizer(tapGesture)
    }
    
    private let toImageView = UIImageView().then {
        $0.image = ImageLiterals.homeImgTo
    }
    
    private let floatingAnimation = ToMEAnimationManager.createFloatingAnimation()
    
    private lazy var topAlertView = TopAlertView().then {
        $0.alpha = 0
    }
    
    private let backgroundLottieView: LottieAnimationView = .init(name: "background")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavibarAnimation()
        setUI()
        setLayout()
        setAddTarget()
        setHaptic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.hideTabBar(wantsToHide: false)
        setBubbleViewAnimation()
        ToMEMusicManager.shared.playMusic(withTitle: "homeBackgroundMusic", loop: -1)   // 무한 반복
        setAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ToMEMusicManager.shared.stopMusic(withTitle: "homeBackgroundMusic")
    }
}

// MARK: - @objc Function

extension HomeMainVC {
    @objc private func talkingWithToBubbleViewDidTap() {
        // 버튼이 눌릴 때 햅틱 피드백 제공
        feedbackGenerator.impactOccurred()
        ToMEMusicManager.shared.playMusicWithTimeInterval(forTitle: "bubble", duration: 2)
        let talkingDetailVC = TalkingMessageVC()
        self.navigationController?.fadeTo(talkingDetailVC)
    }
    
    @objc private func todaysMissionBubbleViewDidTap() {
        // 버튼이 눌릴 때 햅틱 피드백 제공
        feedbackGenerator.impactOccurred()
        ToMEMusicManager.shared.playMusicWithTimeInterval(forTitle: "bubble", duration: 2)
        if isTalkedWithTo {
            let missionMainVC = MissionMainVC()
            self.navigationController?.fadeTo(missionMainVC)
        } else {
            wantsToShowTopAlertVC()
        }
    }
}
// MARK: - Methods

extension HomeMainVC {
    private func setAddTarget() {
        
    }
    
    private func setBubbleViewAnimation() {
        talkingWithToBubbleView.layer.add(floatingAnimation, forKey: "floatingAnimation")
        todaysMissionBubbleView.layer.add(floatingAnimation, forKey: "floatingAnimation")
    }
    
    private func setNavibarAnimation() {
        ToMEAnimationManager.createSequentialTextAnimation(label: naviBar.centerTitleLabel, text: naviBar.centerTitleLabel.text ?? String())
    }
    
    private func setHaptic() {
        // 햅틱 피드백 준비
        feedbackGenerator.prepare()
    }
    
    private func wantsToShowTopAlertVC() {
        // Alert View를 서서히 나타나도록 애니메이션
        UIView.animate(withDuration: 0.5, animations: {
            self.topAlertView.alpha = 1
        }) { _ in
            // 일정 시간 후에 Alert View를 서서히 사라지도록 애니메이션
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.topAlertView.alpha = 0
                })
            }
        }
    }
    
    private func setAnimation() {
        backgroundLottieView.play()
        backgroundLottieView.loopMode = .loop
    }
}

// MARK: - UI & Layout

extension HomeMainVC {
    private func setUI() {
        view.backgroundColor = .lightGray
    }
    
    private func setLayout() {
        view.addSubview(backgroundLottieView)
        
        backgroundLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubviews(naviBar, talkingWithToBubbleView, todaysMissionBubbleView, toImageView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(298)
        }
        
        talkingWithToBubbleView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(67)
            make.leading.equalToSuperview().inset(32)
            make.width.height.equalTo(125)
        }
        
        todaysMissionBubbleView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).inset(5)
            make.trailing.equalToSuperview().inset(32)
            make.width.height.equalTo(125)
        }
        
        toImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(166)
            make.centerX.equalToSuperview()
            make.width.equalTo(148)
            make.height.equalTo(124)
        }
        
        setTopAlertViewLayout()
    }
    
    private func setTopAlertViewLayout() {
        view.addSubview(topAlertView)
        
        topAlertView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(94)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(65)
        }
    }
}
