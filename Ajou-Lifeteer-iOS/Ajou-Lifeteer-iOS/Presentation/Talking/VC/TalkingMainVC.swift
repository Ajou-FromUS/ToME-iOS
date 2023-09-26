//
//  TalkingMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class TalkingMainVC: UIViewController {
    
    // MARK: - Properties

    var checkQuestionButtonState: Bool = true

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("To. Me")
    
    private let characterImageView = UIImageView()
    
    private let questionButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.talkingBtnQuestion, for: .normal)
    }
    
    private let questionExplainView = UIView().then {
        $0.layer.cornerRadius = 5
    }
    
    private let questionExplainLabel = UILabel().then {
        $0.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        let attributedText = NSAttributedString(
            string: "심리상담가 티오는 당신의 일상이 궁금해요.\n티오에게 오늘 있었던 일을 얘기해 주세요.\n티오는 chat GPT ~~를 ~~하고 있습니다.",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.body2,
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
        )
        $0.attributedText = attributedText
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .subTitle2
        $0.textColor = .font1
        $0.text = "저랑 대화해요!\n오늘 하루는 어떠셨나요?"
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .font3
        $0.text = "티오는 당신의 이야기를 들을 준비가 되어 있어요."
    }
    
    private lazy var startTalkingButton = CustomButton(title: "티오와 대화 시작하기", type: .fillWithBlue)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
}

// MARK: - @objc Function

extension TalkingMainVC {
    @objc private func questionButtonDidTap() {
        questionButtonState()
    }
    
    @objc private func startTalkingButtonDidTap() {
        pushToTalkingDetailVC()
    }
}

// MARK: - Methods

extension TalkingMainVC {
    private func setAddTarget() {
        self.questionButton.addTarget(self, action: #selector(questionButtonDidTap), for: .touchUpInside)
        self.startTalkingButton.addTarget(self, action: #selector(startTalkingButtonDidTap), for: .touchUpInside)
    }
    
    private func questionButtonState() {
        if checkQuestionButtonState {
            showQuestionView()
            checkQuestionButtonState.toggle()
        } else {
            hideQuestionView()
            checkQuestionButtonState.toggle()
        }
    }
    
    private func pushToTalkingDetailVC() {
        let talkingDetailVC = TalkingDetailVC()
        self.navigationController?.fadeTo(talkingDetailVC)
    }
}

// MARK: - UI & Layout

extension TalkingMainVC {
    private func setUI() {
        view.backgroundColor = .kakaoYellow
        characterImageView.backgroundColor = .mainColor
        questionExplainView.backgroundColor = .sub2
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, questionButton, characterImageView, titleLabel, subTitleLabel, startTalkingButton, questionExplainView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        questionButton.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(125)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalTo(142)
            make.height.equalTo(218)
        }
        
        startTalkingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(108)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(52)
        }
        
        questionExplainView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(10)
            make.leading.equalTo(questionButton.snp.trailing)
            make.height.equalTo(76)
            make.width.equalTo(273)
        }
        
        questionExplainView.addSubview(questionExplainLabel)
        
        questionExplainLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        hideQuestionView()
    }
    
    private func showQuestionView() {
        questionExplainView.isHidden = false
        questionExplainLabel.isHidden = false
    }

    private func hideQuestionView() {
        questionExplainView.isHidden = true
        questionExplainLabel.isHidden = true
    }
}
