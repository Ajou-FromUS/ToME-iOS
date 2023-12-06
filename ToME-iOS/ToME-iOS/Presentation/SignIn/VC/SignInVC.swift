//
//  SignInVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/21.
//

import UIKit

import Then
import SnapKit
import Moya
import SafariServices

@frozen
enum LoginType {
    case kakao
    case apple
}

final class SignInVC: UIViewController {
    
    // MARK: - Providers
    
    private let userProvider = Providers.userProvider
    
    // MARK: - UI Components
    
    private let toMeImageView = UIImageView().then {
        $0.image = ImageLiterals.tomeSplashImage
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "나를 위한 웰니스 기록 서비스"
        $0.font = .body2
        $0.textColor = .sub3
    }
    
    private let toMeLogoImageView = UIImageView().then {
        $0.image = ImageLiterals.tomeSplashLogo
    }
    
    private let visitantButton = UIButton().then {
        let titleString = NSMutableAttributedString(string: "회원가입 없이 둘러보기")
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.font3,
            .font: UIFont.body2
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        titleString.addAttribute(.underlineStyle,
                                 value: NSUnderlineStyle.single.rawValue,
                                 range: NSRange(location: 0, length: titleString.length))
        $0.setAttributedTitle(titleString, for: .normal)
    }

    private lazy var kakaoLoginButton = CustomButton(title: "카카오톡으로 로그인", type: .fillWithBlue).then {
        $0.setColor(bgColor: UIColor(hex: "FEE500"), disableColor: .disabled1, titleColor: UIColor(hex: "232323"))
    }
    
    private lazy var appleLoginButton = CustomButton(title: "Apple로 로그인", type: .fillWithBlue).then {
        $0.setColor(bgColor: UIColor(hex: "232323"), disableColor: .disabled1, titleColor: .white)
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
        pushToFuroLoginVC(type: .kakao)
    }
    
    @objc func touchUpAppleLoginButton() {
//        pushToFuroLoginVC(type: .apple)
    }
}

// MARK: - Methods

extension SignInVC {
    private func setAddTarget() {
        self.kakaoLoginButton.addTarget(self, action: #selector(touchUpKakaoLoginButton), for: .touchUpInside)
        self.appleLoginButton.addTarget(self, action: #selector(touchUpAppleLoginButton), for: .touchUpInside)
    }

    private func pushToFuroLoginVC(type: LoginType) {
        switch type {
        case .kakao:
            let furoLoginUrl = NSURL(string: Config.kakaoFuroLoginURL)
            lazy var furoLoginVC: SFSafariViewController = SFSafariViewController(url: furoLoginUrl! as URL)
            furoLoginVC.delegate = self
            self.present(furoLoginVC, animated: true, completion: nil)

        case .apple:
            return
//            let furoLoginUrl = NSURL(string: Config.appleFuroLoginURL)
//            lazy var furoLoginVC: SFSafariViewController = SFSafariViewController(url: furoLoginUrl! as URL)
//            furoLoginVC.delegate = self
//            self.present(furoLoginVC, animated: true, completion: nil)
        }
    }
    
    private func pushToTabBarController() {
        let tabBarController = TabBarController()
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: tabBarController,
                                                  withAnimation: true)
    }
    
    private func pushToRegisterVC() {
        let registerVC = RegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: false)
    }
    
    /// 로그인 통신
    private func pushToFuroLogin(withCode code: String) {
        userProvider.request(.authenticate(code: code)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: response.data, options: [])

                    if let httpResponse = response.response {
                        print("statusCode: \(httpResponse.statusCode)")
                    }

                    if let responseJSON = responseJSON as? [String: Any],
                       let accessToken = responseJSON["access_token"] as? String,
                       let refreshToken = responseJSON["refresh_token"] as? String {

                        DispatchQueue.main.async {
                            UserManager.shared.updateToken(accessToken: accessToken, refreshToken: refreshToken, isKakao: true)
                            print("Login success")
                            self.pushToRegisterVC()   // 회원가입으로 이동
                        }
                    } else {
                        print("Access token or refresh token not found or is nil.")
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UI & Layout

extension SignInVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(toMeImageView, subTitleLabel, toMeLogoImageView, appleLoginButton, kakaoLoginButton, visitantButton)
        
        toMeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview().offset(-70)
            make.width.equalTo(114)
            make.height.equalTo(69)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(toMeImageView.snp.top).inset(10)
            make.centerX.equalToSuperview().offset(70)
        }
        
        toMeLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(7)
            make.width.equalTo(89)
            make.height.equalTo(29)
            make.leading.equalTo(subTitleLabel.snp.leading).offset(-5)
        }
        
        visitantButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(33)
            make.centerX.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(visitantButton.snp.top).offset(-10)
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

// MARK: - SFSafariViewControllerDelegate

extension SignInVC: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        /// 승인 완료 후 Redirection
        print("redirect: ", URL.absoluteString)
        if  URL.absoluteString.contains(Config.redirectURL) {
            let code = URL.absoluteString.components(separatedBy: "code=").last!
            controller.dismiss(animated: true, completion: nil) // redirect 이후 dismiss
            pushToFuroLogin(withCode: code)
        }
    }
}
