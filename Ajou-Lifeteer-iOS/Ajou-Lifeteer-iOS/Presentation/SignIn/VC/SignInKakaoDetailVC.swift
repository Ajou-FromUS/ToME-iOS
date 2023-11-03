//
//  SignInKakaoDetailVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/21.
//

import UIKit

import Then
import SnapKit
import Moya
import SafariServices

final class SignInKaKaoDetailVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var kakaoSimpleLoginButton = CustomButton(title: "카카오톡으로 간편 로그인", type: .fillWithBlue).then {
        $0.setColor(bgColor: UIColor(hex: "FEE600"), disableColor: .disabled1, titleColor: .appleBlack)
    }
        
    private let kakaoOtherAccountLoginButton = UIButton(type: .system).then {
        $0.setTitle("다른 카카오 계정으로 로그인", for: .normal)
        $0.titleLabel?.font = .body1
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.clear, for: .normal)
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    private lazy var closeButton = UIButton(type: .system).then {
        $0.setImage(ImageLiterals.diaryImgAlbum, for: .normal)
        $0.tintColor = UIColor.white
        $0.addTarget(self, action: #selector(touchUpCloseImageView), for: .touchUpInside)
    }
    
    private let loginLabel = UILabel().then {
        $0.text = "Login"
        $0.font = .body1
        $0.textColor = .white
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
        setLayout()
        setAddTarget()
        // kakaoView.delegate = self
    }
}

// MARK: - @objc Methods

extension SignInKaKaoDetailVC {
    @objc private func popToPreviousVC() {
        self.dismiss(animated: false)
    }
    
    @objc private func touchUpCloseImageView() {
        popToPreviousVC()
    }
    
    @objc private func kakaoSimpleLoginButtonDidTap() {
        // self.present(self.kakaoView, animated: true, completion: nil)
    }
}

// MARK: - Methods

extension SignInKaKaoDetailVC {
    private func setAddTarget() {
        self.kakaoSimpleLoginButton.addTarget(self, action: #selector(kakaoSimpleLoginButtonDidTap), for: .touchUpInside)
    }
}

// MARK: - UI & Layout

extension SignInKaKaoDetailVC {
    private func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
    }
    
    private func setNavigationBar() {
    }
    
    private func setLayout() {
        view.addSubviews(closeButton, kakaoSimpleLoginButton, kakaoOtherAccountLoginButton, loginLabel)
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        kakaoOtherAccountLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(closeButton.snp.top).offset(-48)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        kakaoSimpleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoOtherAccountLoginButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoSimpleLoginButton.snp.top).offset(-24)
            make.centerX.equalToSuperview()
        }
    }
}
