//
//  SignInVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/21.
//

import UIKit

import Then
import SnapKit

final class SignInVC: UIViewController {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView().then {
        $0.image = ImageLiterals.icMindsetBI
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "마음을 정리하는 시간,"
        $0.font = .b1
        $0.textColor = .mainGreen
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "마음짓기"
        $0.font = .h0
        $0.textColor = .mainGreen
    }
    
    private let visitantButton = UIButton().then {
        let titleString = NSMutableAttributedString(string: "회원가입 없이 둘러보기")
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.disabledText,
            .font: UIFont.b2
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        titleString.addAttribute(.underlineStyle,
                                 value: NSUnderlineStyle.single.rawValue,
                                 range: NSRange(location: 0, length: titleString.length))
        $0.setAttributedTitle(titleString, for: .normal)
    }

    private lazy var kakaoLoginButton = CustomButton(title: "카카오톡으로 시작하기", type: .fillWithGreen).then {
        $0.setColor(bgColor: UIColor(hex: "FEE600"), disableColor: .disabledFill, titleColor: .mainBlack)
    }
    
    private lazy var appleLoginButton = CustomButton(title: "Apple로 로그인", type: .fillWithGreen).then {
        $0.setColor(bgColor: .mainBlack, disableColor: .disabledFill, titleColor: .white)
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
}

// MARK: - @objc Methods

extension SignInVC {
    @objc func touchUpKakaoLoginButton() {
        pushToSignInKaKaoDetailVC()
    }
}

// MARK: - Methods

extension SignInVC {
    private func setAddTarget() {
        self.kakaoLoginButton.addTarget(self, action: #selector(touchUpKakaoLoginButton), for: .touchUpInside)
    }
    
    private func pushToSignInKaKaoDetailVC() {
        let signInKaKaoDetailVC = SignInKaKaoDetailVC()
        signInKaKaoDetailVC.modalPresentationStyle = .overFullScreen
        self.present(signInKaKaoDetailVC, animated: false)
    }
}

// MARK: - UI & Layout

extension SignInVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(logoImageView, subTitleLabel, titleLabel, appleLoginButton, kakaoLoginButton, visitantButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(159)
            make.width.equalTo(103)
            make.height.equalTo(73)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        visitantButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
