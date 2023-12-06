//
//  RegisterVC.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 12/6/23.
//

import UIKit

import SnapKit
import Then
import Moya

final class RegisterVC: UIViewController {
    
    // MARK: - Provider
    
    private let userProvider = Providers.userProvider
    
    // MARK: - Properties

    private let nicknameMaxLength: Int = 8
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("회원가입")
    
    private let subLabel = UILabel().then {
        $0.text = "투미와 친구가 되기 위해\n정보를 입력해주세요."
        $0.textColor = .font1
        $0.font = .newBody3
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 5)
    }
    
    private let nickNameSubLabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .disabled1
        $0.font = .body2
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.resignFirstResponder()
        $0.textColor = .font1
        $0.font = .newBody3
        $0.textAlignment = .left
        $0.attributedPlaceholder = NSAttributedString(
            string: "닉네임을 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.font2, NSAttributedString.Key.font: UIFont.newBody3]
        )
        $0.keyboardType = .webSearch
    }
    
    private let characterCountLabel = UILabel().then {
        $0.textColor = .disabled1
        $0.font = .body2
    }
    
    private lazy var registerButton = CustomButton(title: "티오와 함께 투미 시작하기", type: .fillWithBlue).then {
        $0.isEnabled = false
    }
    
    private let horizontalDividedView = UIView()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setDelegate()
        updateCharacterCountLabel()
    }
}

// MARK: - @objc Function

extension RegisterVC {
    @objc private func registerButtonDidTap() {
        guard let nickname = self.nickNameTextField.text else { return }
        createUser(nickname: nickname)
    }
}

// MARK: - Methods

extension RegisterVC {
    private func setAddTarget() {
        self.registerButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
    }
    
    private func setDelegate() {
        self.nickNameTextField.delegate = self
    }
    
    // 입력된 글자 수 업데이트
    private func updateCharacterCountLabel() {
        let currentCharacterCount = nickNameTextField.text?.count ?? 0
        characterCountLabel.text = "\(currentCharacterCount)/\(nicknameMaxLength)"
    }
    
    private func pushToTabBarController() {
        let tabBarController = TabBarController()
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: tabBarController,
                                                  withAnimation: true)
    }
}

// MARK: - UI & Layout

extension RegisterVC {
    private func setUI() {
        view.backgroundColor = .white
        horizontalDividedView.backgroundColor = .disabled1
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, subLabel, nickNameSubLabel, nickNameTextField,
                         characterCountLabel, registerButton, horizontalDividedView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(27)
        }
        
        nickNameSubLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(50)
            make.leading.equalTo(subLabel.snp.leading)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameSubLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        horizontalDividedView.snp.makeConstraints { make in
            make.bottom.equalTo(nickNameTextField.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(1)
        }
        
        characterCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameTextField.snp.centerY)
            make.trailing.equalTo(nickNameTextField.snp.trailing)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(58)
            make.leading.trailing.equalToSuperview().inset(26)
            make.height.equalTo(58)
        }
    }
}

// MARK: - UITextFieldDelegate

extension RegisterVC: UITextFieldDelegate {
    // 한 글자 입력시 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        // 공백일 경우
        if string == " " {
            return false
        }
        
        if string.hasCharacters() || isBackSpace == -92 {
            // 현재 입력된 글자 수
            let currentCharacterCount = (textField.text ?? "").count
            
            // 최대 글자 수를 초과하면 입력을 차단
            if currentCharacterCount + string.count - range.length > nicknameMaxLength {
                return false
            }
            
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerButton.isEnabled = textField.isEmpty ? false : true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 글자수 업데이트
        updateCharacterCountLabel()
    }
}

// MARK: - Network

extension RegisterVC {
    private func createUser(nickname: String) {
        LoadingIndicator.showLoading()
        userProvider.request(.createUser(nickname: nickname)) { [weak self] response in
            guard let self = self else { return }
            LoadingIndicator.hideLoading()
            switch response {
            case .success(let result):
                let status = result.statusCode
                if 200..<300 ~= status {
                    do {
                        self.pushToTabBarController()    // 메인 화면으로 이동
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if status >= 400 {
                    print("400 error")
                    self.showNetworkFailureToast()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.showNetworkFailureToast()
            }
        }
    }
}
