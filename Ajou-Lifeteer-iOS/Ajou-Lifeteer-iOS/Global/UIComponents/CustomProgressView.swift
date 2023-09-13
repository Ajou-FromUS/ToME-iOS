//
//  CustomProgressView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import UIKit

final class CustomProgressView: UIProgressView {

    // MARK: - Initialize

    public init(progress: Float) {
        super.init(frame: .zero)
        self.setUI(progress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension CustomProgressView {
    private func setUI(_ progress: Float) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setProgress(progress, animated: true)
        self.progressTintColor = .mainColor
        self.trackTintColor = .sub2
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.layer.sublayers![1].cornerRadius = 4
        self.subviews[1].clipsToBounds = true
    }
}
