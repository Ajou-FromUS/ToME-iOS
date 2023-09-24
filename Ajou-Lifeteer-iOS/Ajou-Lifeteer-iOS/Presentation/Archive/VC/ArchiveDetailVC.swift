//
//  ArchiveDetailVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/13.
//

import UIKit

import SnapKit
import Then

final class ArchiveDetailVC: UIViewController {
    
    // MARK: - Properties

    private let textViewPlaceholder = "답변을 입력해주세요."
    var keyboardPresent = false
    
    // MARK: - UI Components
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var naviBar = CustomNavigationBar(self, type: .withoutBackground).setTitle("아카이브")
    
    private lazy var saveButton = CustomButton(title: "저장 완료하기", type: .fillWithBlue).then {
        $0.isEnabled = false
    }
    
    private let questionNumberLabel = UILabel().then {
        $0.font = .questionNumber
        $0.textColor = .mainColor
    }
    
    private let questionLabel = UILabel().then {
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private let isLabel = UILabel().then {
        $0.text = "입니다."
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var answerTextView = UITextView().then {
        $0.textAlignment = .center
        $0.text = textViewPlaceholder
        $0.font = .body1
        $0.textContainerInset = UIEdgeInsets(top: 30, left: 24,
                                             bottom: 30, right: 24)
        $0.layer.cornerRadius = 12
        $0.textColor = .font3
    }

    private let countByteLabel = UILabel().then {
        $0.text = "0/80자"
        $0.font = .body2
        $0.textColor = .font3
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionNumberLabel.text = "01."
        self.questionLabel.text = "나의 별명은?"
        setUI()
        setLayout()
        setDelegate()
        setAddTarget()
        self.view = view
        setKeyboardNotification()
        setTapGesture()
    }
}

// MARK: - @objc Function

extension ArchiveDetailVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardPresent, let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.frame.origin.y -= keyboardFrame.height - 270
            keyboardPresent = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardPresent, let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.frame.origin.y += keyboardFrame.height - 270
            keyboardPresent = false
        }
    }
}

// MARK: - @objc Function

extension ArchiveDetailVC {
    @objc private func saveButtonDidTap() {
        pushToSureToSavePopUpVC()
    }
}

// MARK: - Methods

extension ArchiveDetailVC {
    private func setDelegate() {
        self.answerTextView.delegate = self
    }
    
    private func setAddTarget() {
        self.saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    private func pushToSureToSavePopUpVC() {
        let sureTosavePopUpVC = CustomSureToSavePopUpVC(questionNumber:
                                                            self.questionNumberLabel.text ?? String(),
                                                        questionString:
                                                            self.questionLabel.text ?? String(),
                                                        answerString:
                                                            self.answerTextView.text)
        sureTosavePopUpVC.modalPresentationStyle = .overFullScreen
        self.present(sureTosavePopUpVC, animated: false)
    }
    
    private func completionButton(isOn: Bool) {
        switch isOn {
        case true:
            self.saveButton.isEnabled = true
        case false:
            self.saveButton.isEnabled = false
        }
    }
    
    // 키보드가 올라오면 scrollView 위치 조정
    private func setKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    // 화면 터치 시 키보드 내리기
    private func setTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

// MARK: - UI & Layout

extension ArchiveDetailVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        answerTextView.backgroundColor = .back1
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, scrollView, saveButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(108)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(52)
        }
        
        scrollView.addSubviews(questionNumberLabel, questionLabel, answerTextView, countByteLabel, isLabel)
        
        questionNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionNumberLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        answerTextView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(173)
        }
                
        isLabel.snp.makeConstraints { make in
            make.top.equalTo(answerTextView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
        
        countByteLabel.snp.makeConstraints { make in
            make.trailing.equalTo(answerTextView.snp.trailing).inset(14)
            make.bottom.equalTo(answerTextView.snp.bottom).inset(12)
        }
    }
}

// MARK: - UITextViewDelegate

extension ArchiveDetailVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            answerTextView.textColor = .font2
            answerTextView.font = .subTitle2
            answerTextView.text = nil
        }
        
        if textView.text.count > 1 {
            self.saveButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .font3
            textView.font = .body1
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ""
            self.completionButton(isOn: false)
        } else {
            self.completionButton(isOn: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        countByteLabel.text = "\(changedText.count)/80자"
        
        if Int(changedText) ?? 0 > 1 {
            self.saveButton.isEnabled = true
        }
        
        return changedText.count < 80
    }
}
