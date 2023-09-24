//
//  CustomSureToSavePopUpVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/15.
//

import UIKit

import SnapKit
import Then

final class CustomSureToSavePopUpVC: UIViewController {
    
    // MARK: - UI Components
    
    private let blurEffect = UIBlurEffect(style: .light)
    
    private lazy var visualEffectView = UIVisualEffectView(effect: blurEffect).then {
        $0.frame = self.view.frame
    }
        
    private let titleLabel = UILabel().then {
        $0.font = .subTitle1
        $0.textColor = .font1
        $0.text = "오늘의 아카이브를 저장할까요?"
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .body1
        $0.textColor = .font2
        $0.text = "저장된 아카이브는 수정이 불가해요."
    }
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.disabled1.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    private let questionNumberLabel = UILabel().then {
        $0.font = .questionNumber
        $0.textColor = .mainColor
    }
    
    private let questionLabel = UILabel().then {
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private let answerLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    private let isLabel = UILabel().then {
        $0.text = "입니다."
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var saveButton = CustomButton(title: "네, 저장할게요.", type: .fillWithBlue)
    
    private lazy var cancelButton = CustomButton(title: "아니요, 수정할래요.", type: .fillWithBlue).setColor(bgColor: .disabled1, disableColor: .disabled1, titleColor: .font2)
    
    // MARK: - initialization
    
    init(questionNumber: String, questionString: String, answerString: String) {
        super.init(nibName: nil, bundle: nil)
        setLayout(questionNumber, questionString, answerString)
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

// MARK: - @objc Function

extension CustomSureToSavePopUpVC {
    @objc private func saveButtonDidTap() {
        dismiss(animated: false)
    }
    
    @objc private func cancelButtonDidTap() {
        dismiss(animated: false)
    }
}

// MARK: - Methods

extension CustomSureToSavePopUpVC {
    private func setAddTarget() {
        self.saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }
}

// MARK: - UI & Layout

extension CustomSureToSavePopUpVC {
    private func setUI() {
        self.containerView.backgroundColor = .white
    }
    
    private func setLayout(_ questionNumber: String, _ questionString: String, _ answerString: String) {
        self.questionNumberLabel.text = questionNumber
        self.questionLabel.text = questionString
        setAnswerLabelUI(answerString)
        
        view.addSubviews(visualEffectView, titleLabel, subTitleLabel,
                         containerView, saveButton, cancelButton)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.centerY.equalToSuperview().offset(-20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top).offset(-18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-10)
        }
        
        setContainerViewLayout()
 
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(14)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(52)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(52)
        }
    }
    
    private func setContainerViewLayout() {
        containerView.addSubviews(questionNumberLabel, questionLabel, answerLabel, isLabel)
        
        questionNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(54)
            make.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionNumberLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(39)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        isLabel.snp.makeConstraints { make in
            make.top.equalTo(answerLabel.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(isLabel.snp.bottom).offset(54)
        }
    }
    
    private func setAnswerLabelUI(_ answerLabelText: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center

        let attributedText = NSAttributedString(
            string: answerLabelText,
            attributes: [
                .font: UIFont.subTitle2,
                .foregroundColor: UIColor.font2,
                .paragraphStyle: paragraphStyle
            ]
        )

        self.answerLabel.attributedText = attributedText
    }
}
