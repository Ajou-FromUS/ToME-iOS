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
    
    private let toMeImageView = UIImageView().then {
        $0.image = ImageLiterals.tomeSplashImage
    }
    
    private let subTitleLabel = UILabel().then {
        $0.alpha = 0
        $0.text = "나를 위한 웰니스 기록 서비스"
        $0.font = .body2
        $0.textColor = .sub3
    }
    
    private let toMeLogoImageView = UIImageView().then {
        $0.alpha = 0
        $0.image = ImageLiterals.tomeSplashLogo
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
            self.toMeImageView.transform = CGAffineTransform(translationX: -65, y: 0)
            self.toMeLogoImageView.alpha = 1.0
            self.subTitleLabel.alpha = 1.0
            self.toMeLogoImageView.transform = CGAffineTransform(translationX: 75, y: 0)
            self.subTitleLabel.transform = CGAffineTransform(translationX: 75, y: 0)
        }, completion: { _ in
            self.checkDidSignIn()
        })
    }
    
    /// animation 이후 탭바 컨트롤러로 이동
    
    private func checkDidSignIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if UserManager.shared.hasAccessToken {
                    UserManager.shared.getNewToken { [weak self] result in
                        switch result {
                        case .success:
                            print("SplashVC-토큰 재발급 성공")
                            self?.pushToTabBarController()
                        case .failure(let error):
                            print(error)
                            self?.pushToSignInView()
                        }
                    }
                } else {
                    self.pushToSignInView()
                }
            }
        }
    }
    
    /// 토큰이 있을 경우, 로그인된 기존 유저이므로 홈화면으로 이동
    
    private func pushToTabBarController() {
        let tabBarController = TabBarController()
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: tabBarController,
                                                  withAnimation: true)
    }
    
    /// 토큰이 없을 경우, 재로그인 필요하므로 로그인 화면으로 이동
    
    private func pushToSignInView() {
        let signInVC = SignInVC()
        self.navigationController?.pushViewController(signInVC, animated: true)
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
        view.addSubviews(subTitleLabel, toMeLogoImageView, toMeImageView)
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        toMeLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            make.width.equalTo(89)
            make.height.equalTo(29)
            make.leading.equalTo(subTitleLabel.snp.leading).offset(-5)
        }
        
        toMeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(114)
            make.height.equalTo(69)
        }
    }
}
