//
//  InquiryView.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/21/23.
//

import UIKit

import SnapKit
import Then

final class InquiryView: UIView {
    
    // MARK: - UI Components

    private let subTitle = UILabel().then {
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.font = .body2
        $0.textColor = .mainColor
        $0.text = "'FromUS' 카카오톡 플러스친구를 추가해 문의해주세요.\n문의 답변 시간 : 평일 오전 9시 ~ 오후 5시"
        $0.setLineSpacing(lineSpacing: 6)
    }
    
    private let kakaoToImageView = UIImageView().then {
        $0.image = ImageLiterals.kakaoInquiryImg
    }
    
    private lazy var kakaoPlusButton = CustomButton(title: "카카오톡 플러스친구 보러가기", type: .fillWithBlue)
    
    // MARK: - Initialize

    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension InquiryView {
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubviews(subTitle, kakaoToImageView, kakaoPlusButton)
        
        subTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        kakaoToImageView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(87)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(kakaoToImageView.snp.width)
        }
        
        kakaoPlusButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
    }
}
