//
//  SplashVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/21.
//

import UIKit

import SnapKit
import Then

final class SplashVC: UIViewController {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView().then {
        $0.image = ImageLiterals.icMindsetBI
    }
    
    private let subTitleLabel = UILabel().then {
        $0.alpha = 0
        $0.text = "마음을 정리하는 시간,"
        $0.font = .b1
        $0.textColor = .mainGreen
    }
    
    private let titleLabel = UILabel().then {
        $0.alpha = 0
        $0.text = "마음짓기"
        $0.font = .h0
        $0.textColor = .mainGreen
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
        setLogoAnimation()
    }
}

// MARK: - Methods

extension SplashVC {
    
    /// setting animation

    private func setLogoAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -65)
        }, completion: { _ in
            self.setLabelsAnimation()
        })
    }
    
    private func setLabelsAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.subTitleLabel.alpha = 1.0
            self.titleLabel.alpha = 1.0
        }, completion: { _ in
            self.checkDidSignIn()
        })
    }
    
    /// animation 이후 탭바 컨트롤러로 이동
     
    private func checkDidSignIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pushToTabBarController()
        }
    }
    
    private func pushToTabBarController() {
        let tabBarController = TabBarController()
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: tabBarController,
                                                  withAnimation: true)
    }
}

// MARK: - UI & Layout

extension SplashVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setLayout() {
        view.addSubviews(logoImageView, subTitleLabel, titleLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(103)
            make.height.equalTo(73)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(370)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
