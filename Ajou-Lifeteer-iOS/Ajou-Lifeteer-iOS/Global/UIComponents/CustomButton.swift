//
//  CustomButton.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

@frozen
enum BtnType {
    case fillWithGreen  // 초록 버튼
    case borderWithoutBGC   // 배경 없이 테두리만 있는 버튼
    case selectWeather  // 날씨 버튼
}

public class CustomButton: UIButton {
    
    // MARK: - Initialize
    
    init(title: String, type: BtnType) {
        super.init(frame: .zero)
        self.setUI(title, type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomButton {
    /// 버튼의 enable 여부 설정
    @discardableResult
    public func setEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    /// 버튼의 Title 변경
    @discardableResult
    public func changeTitle(string: String) -> Self {
        self.setTitle(string, for: .normal)
        return self
    }
    
    /// 버튼에 image 추가 (weather 버튼일 경우)
    @discardableResult
    public func setWeatherImage(image: UIImage) -> Self {
        self.setImage(image, for: .normal)
        return self
    }
    
    /// 버튼의 backgroundColor, textColor 변경
    @discardableResult
    public func setColor(bgColor: UIColor, disableColor: UIColor) -> Self {
        self.setBackgroundColor(bgColor, for: .normal)
        self.setBackgroundColor(disableColor, for: .disabled)
        self.setAttributedTitle(
            NSAttributedString(
                string: self.titleLabel?.text ?? "",
                attributes: [.font: UIFont.h6, .foregroundColor: UIColor.mainGreen]),
            for: .normal)
        
        return self
    }
}

// MARK: - UI & Layout

extension CustomButton {
    private func setUI(_ title: String, _ type: BtnType) {
        self.layer.cornerRadius = 5
        
        switch type {
        case .fillWithGreen:
            self.setBackgroundColor(.mainGreen, for: .normal)
            self.setBackgroundColor(.disabledFill, for: .disabled)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.h6, .foregroundColor: UIColor.mainBackground]
                ),
                for: .normal
            )
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.h6, .foregroundColor: UIColor.disabledText]
                ),
                for: .disabled
            )

        case .borderWithoutBGC:
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.mainGreen.cgColor
            self.setBackgroundColor(.clear, for: .normal)
            self.setTitleColor(.mainGreen, for: .normal)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.h6, .foregroundColor: UIColor.mainGreen]
                ),
                for: .normal
            )
        case .selectWeather:
            self.setBackgroundColor(.mainGreen, for: .normal)
            self.setBackgroundColor(.disabledFill, for: .disabled)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.b3, .foregroundColor: UIColor.mainBackground]
                ),
                for: .normal
            )
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.b3, .foregroundColor: UIColor.disabledText]
                ),
                for: .disabled
            )
            self.semanticContentAttribute = .forceRightToLeft   // 이미지를 텍스트의 왼쪽으로 설정
        }
    }
}
