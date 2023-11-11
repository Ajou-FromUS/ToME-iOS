//
//  TopAlertView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

class TopAlertView: UIView {
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.text = "오늘의 미션이 없어요.\n티오와 대화하여 미션을 수행하세요!"
        $0.font = .body2
        $0.textColor = .white
        $0.setLineSpacing(lineSpacing: 3)
    }
    
    private let warningImageView = UIImageView().then {
        $0.image = ImageLiterals.warningIc
    }

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

extension TopAlertView {
    private func setUI() {
        self.containerView.backgroundColor = .popUpBackground.withAlphaComponent(0.8)
    }
    
    private func setLayout() {
        self.addSubviews(containerView, titleLabel, warningImageView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        warningImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(27)
            make.width.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(warningImageView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
    }
}
