//
//  CustomNavigationBar.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

@frozen
enum NaviType {
    case home // 홈에 존재하는 네비바
    case singleTitle // 타이틀이 한줄인 네비바
    case singleTitleWithPopButton // 타이틀 한 줄 + 뒤로가기 버튼 (티오랑 대화하기)
    case singleTitleWithBackButton // 타이틀 한 줄 + 뒤로가기 버튼 (마이페이지)
}

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    private var naviType: NaviType!
    private var vc: UIViewController?
    private var backButtonClosure: (() -> Void)?
    private var menuButtonClosure: (() -> Void)?

    // MARK: - UI Components
    
    var centerTitleLabel = UILabel()
    private let mindSetBIImageView = UIImageView()
    
    private let navibarBackgroundView = UIImageView().then {
        $0.image = ImageLiterals.navibarBackground
    }
    
    private let finishTalkingButton = UIButton(type: .custom).then {
        $0.setTitle("대화 마치기", for: .normal)
        $0.setTitleColor(.sub2, for: .normal)
        $0.setBackgroundColor(.sub1, for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.sub2.cgColor
        $0.titleLabel?.font = UIFont(name: "LeeSeoYun", size: 14)
    }
    
    private let logoLabel = UILabel().then {
        $0.text = "to Me"
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = ImageLiterals.tomeLogo
    }
    
    private let backButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.mypageIcBack, for: .normal)
    }
    
    // MARK: - initialization
    
    init(_ vc: UIViewController, type: NaviType) {
        super.init(frame: .zero)
        self.vc = vc
        self.setUI(type)
        self.setLayout(type)
        self.setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomNavigationBar {
    private func setAddTarget() {
        self.backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        self.finishTalkingButton.addTarget(self, action: #selector(finishTalkingButtonDidTap), for: .touchUpInside)
    }
    
    @discardableResult
    func setUserName(_ name: String) -> Self {
        self.centerTitleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9

        let attributedText = NSAttributedString(
            string: "To. 내 친구 \(name),\n오늘도 나랑 대화하자",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.newBody1,
                NSAttributedString.Key.foregroundColor: UIColor.font1
            ]
        )
        
        self.centerTitleLabel.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func setTitle(_ title: String) -> Self {
        self.centerTitleLabel.font = .newBody1
        self.centerTitleLabel.text = title
        return self
    }
    
    @discardableResult
    func resetBackButtonAction(_ closure: (() -> Void)? = nil) -> Self {
        self.backButtonClosure = closure
        self.backButton.removeTarget(self, action: nil, for: .touchUpInside)
        if closure != nil {
            self.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        } else {
            self.setAddTarget()
        }
        return self
    }
}

// MARK: - @objc Function

extension CustomNavigationBar {
    @objc private func popToPreviousVC() {
        self.vc?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonDidTap() {
        self.backButtonClosure?()
    }
    
    @objc private func finishTalkingButtonDidTap() {
        self.vc?.navigationController?.popViewController(animated: false)
    }
    
    @objc private func mypageButtonDidTap() {
        let mypageMainVC = MyPageMainVC()
        self.vc?.navigationController?.pushViewController(mypageMainVC, animated: false)
    }
}

// MARK: - UI & Layout

extension CustomNavigationBar {
    private func setBackgroundUI() {
        self.backgroundColor = .clear
    }
    
    private func setTitleUI() {
        centerTitleLabel.textColor = .font1
        centerTitleLabel.isHidden = false
    }

    private func setUI(_ type: NaviType) {
        self.naviType = type
        
        switch type {
        case .home:
            setBackgroundUI()
            setTitleUI()
        case .singleTitle:
            setBackgroundUI()
            setTitleUI()
        case .singleTitleWithPopButton:
            setBackgroundUI()
            setTitleUI()
        case .singleTitleWithBackButton:
            setBackgroundUI()
            setTitleUI()
        }
    }
    
    private func setLayout(_ type: NaviType) {
        switch type {
        case .home:
            setHomeLayout()
        case .singleTitle:
            setHomeLayout()
        case .singleTitleWithPopButton:
            self.addSubview(navibarBackgroundView)
            
            navibarBackgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            setHomeLayout()
            
            self.addSubview(finishTalkingButton)
            
            finishTalkingButton.snp.makeConstraints { make in
                make.top.equalTo(centerTitleLabel.snp.top)
                make.trailing.equalToSuperview().inset(26)
                make.height.equalTo(26)
                make.width.equalTo(85)
            }
        case .singleTitleWithBackButton:
            self.addSubviews(backButton, centerTitleLabel)
            
            backButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(60)
                make.leading.equalToSuperview().inset(27)
                make.height.equalTo(16)
                make.width.equalTo(8)
            }
            
            centerTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(backButton.snp.bottom).offset(20)
                make.leading.equalTo(backButton.snp.leading)
            }
        }
    }
    
    private func setBackButtonLayout() {
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
    }
    
    private func setBackButtonWithTitleLayout() {
        self.addSubviews(backButton, centerTitleLabel)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setButtonsWithTitleLayout() {
        self.addSubviews(backButton, mindSetBIImageView, centerTitleLabel)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(11)
        }
        
        mindSetBIImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(31)
            make.width.equalTo(43)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setOnlyBILayout() {
        self.addSubview(mindSetBIImageView)
        
        mindSetBIImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(31)
            make.width.equalTo(43)
        }
    }
    
    private func setOnlyTitleLayout() {
        self.addSubviews(logoLabel, centerTitleLabel)
        
        centerTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(27)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(76)
            make.leading.equalTo(centerTitleLabel.snp.leading)
        }
    }
    
    private func setHomeLayout() {
        self.addSubviews(logoImageView, centerTitleLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(69)
            make.leading.equalToSuperview().inset(27)
            make.width.equalTo(45)
            make.height.equalTo(11)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(27)
        }
    }
}
