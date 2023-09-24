//
//  CustomButton.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

@frozen
enum BtnType {
    case fillWithBlue  // 파란 버튼
    case borderWithoutBGC   // 배경 없이 테두리만 있는 버튼
    case selectWeather  // 날씨 버튼
    
    case edgeRound  // (아카이브) 엣지 라운드처리 버튼
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
    public func setColor(bgColor: UIColor, disableColor: UIColor, titleColor: UIColor) -> Self {
        self.setBackgroundColor(bgColor, for: .normal)
        self.setBackgroundColor(disableColor, for: .disabled)
        self.setAttributedTitle(
            NSAttributedString(
                string: self.titleLabel?.text ?? "",
                attributes: [.font: UIFont.body1, .foregroundColor: titleColor]),
            for: .normal)
        
        return self
    }
}

// MARK: - UI & Layout

extension CustomButton {
    private func setUI(_ title: String, _ type: BtnType) {
        self.layer.cornerRadius = 5
        
        switch type {
        case .fillWithBlue:
            self.setBackgroundColor(.mainColor, for: .normal)
            self.setBackgroundColor(.disabled1, for: .disabled)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.font4]
                ),
                for: .normal
            )
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.font3]
                ),
                for: .disabled
            )

        case .borderWithoutBGC:
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.mainColor.cgColor
            self.setBackgroundColor(.clear, for: .normal)
            self.setTitleColor(.mainColor, for: .normal)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.mainColor]
                ),
                for: .normal
            )
        case .selectWeather:
            self.setBackgroundColor(.mainColor, for: .normal)
            self.setBackgroundColor(.disabled1, for: .disabled)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.mainColor]
                ),
                for: .normal
            )
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.disabled1]
                ),
                for: .disabled
            )
            self.semanticContentAttribute = .forceRightToLeft   // 이미지를 텍스트의 왼쪽으로 설정
            
        case .edgeRound:
            self.layer.cornerRadius = 23
            self.setBackgroundColor(.font4, for: .normal)
            self.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.body1, .foregroundColor: UIColor.font1]
                ),
                for: .normal
            )
        }
    }
}
