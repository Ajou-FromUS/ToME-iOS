//
//  CustomAlertVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

@frozen
enum AlertType {
    case checkAlert // 확인 버튼만 있는 경우
    case yesOrNoAlert // 네, 아니오 버튼이 있는 경우
    case changeNicknameAlert    // 닉네임 변경 팝업
}

final class CustomAlertVC: UIViewController {
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .body1
        $0.textColor = .appleBlack
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .disabled1
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var fillWithGreenButton = CustomButton(title: String(), type: .fillWithBlue)
    
    private lazy var borderWithoutBGCButton = CustomButton(title: String(), type: .borderWithoutBGC)
    
    private let quitButton = UIImageView().then {
        $0.image = ImageLiterals.diaryImgAlbum
    }
    
    // MARK: - initialization
    
    init(title: String, type: AlertType) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        setLayout(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAddTarget()
    }
}

// MARK: - Methods

extension CustomAlertVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            dismiss(animated: false)
        }
    }
    
    @discardableResult
    func setButtonTitle(fillWithGreenButtonTitle: String, borderWithoutBGCButtonTitle: String) -> Self {
        self.fillWithGreenButton.changeTitle(string: fillWithGreenButtonTitle)
        self.borderWithoutBGCButton.changeTitle(string: borderWithoutBGCButtonTitle)
        return self
    }

    @discardableResult
    func setDescriptionLabel(description: String) -> Self {
        self.descriptionLabel.text = description
        return self
    }
    
    private func setAddTarget() {
        
    }
}

// MARK: - UI & Layout

extension CustomAlertVC {
    private func setUI() {
        view.backgroundColor = .appleBlack.withAlphaComponent(0.8)
        containerView.backgroundColor = .white
    }
    
    private func setLayout(_ type: AlertType) {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        switch type {
        case .checkAlert:
            setCheckAlertLayout()
        case .yesOrNoAlert:
            setYesOrNoAlertLayout()
        case .changeNicknameAlert:
            setChangeNicknameAlertLayout()
        }
    }
    
    private func setCheckAlertLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(162)
        }
        
        containerView.addSubviews(titleLabel, fillWithGreenButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
        }
        
        fillWithGreenButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(46)
            make.height.equalTo(44)
        }
    }
    
    private func setYesOrNoAlertLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(188)
        }
        
        containerView.addSubviews(titleLabel, descriptionLabel, fillWithGreenButton, borderWithoutBGCButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        borderWithoutBGCButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(containerView.snp.centerX).inset(10)
            make.bottom.equalToSuperview().inset(46)
            make.height.equalTo(44)
        }
        
        fillWithGreenButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(containerView.snp.centerX).offset(10)
            make.bottom.equalToSuperview().inset(46)
            make.height.equalTo(44)
        }
    }
    
    private func setChangeNicknameAlertLayout() {
        
    }
}
