//
//  ToMETextViewManager.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/8/23.
//

import UIKit

import SnapKit

class ToMeTextViewManager: UITextView, UITextViewDelegate {
    
    var maxCount = Int()
        
    // MARK: - Properties

    var placeholder: String
    var onTextChange: ((Bool) -> Void)? // 클로저 선언
    
    // MARK: - UI Components
    
    private let borderBackgroundImageView = UIImageView().then {
        $0.image = ImageLiterals.missionImgTextBorder
    }
    
    // MARK: - Initializer
    
    init(placeholder: String, maxCount: Int) {
        self.placeholder = placeholder
        self.maxCount = maxCount
        super.init(frame: CGRect.zero, textContainer: nil)
        // 텍스트뷰 초기 설정
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupTextView() {
        self.delegate = self
        self.text = placeholder
        self.setLineSpacing(lineSpacing: 15)
        self.textAlignment = .center
        self.font = .newBody3
        self.textContainerInset = UIEdgeInsets(top: 25, left: 40, bottom: 23, right: 40)
        self.layer.cornerRadius = 12
        self.textColor = .disabled1
        
        self.addSubview(borderBackgroundImageView)
        
        borderBackgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func updateTextViewAppearance() {
        if self.text == placeholder {
            self.textColor = .disabled1
            self.font = .newBody3
            self.text = nil
        }
    }
    
    private func isTextViewEmpty() -> Bool {
        return self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func isTextViewValid() -> Bool {
        return !self.text.isEmpty && self.text.count <= self.maxCount
    }
}

// MARK: - UITextViewDelegate

extension ToMeTextViewManager {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.textColor = .disabled1
            self.text = placeholder
            
        } else if self.text == placeholder {
            self.textColor = .font2
            self.text = nil
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if isTextViewEmpty() {
            onTextChange?(false)
        } else {
           // 클로저 호출, 텍스트 뷰의 텍스트 전달
            onTextChange?(true)
        }
        
        if self.text.count > self.maxCount {
            self.deleteBackward()
        }
    
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            self.textColor = .disabled1
            self.text = placeholder
        }
    }
}
