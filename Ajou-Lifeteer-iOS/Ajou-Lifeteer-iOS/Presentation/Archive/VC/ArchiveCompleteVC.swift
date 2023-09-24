//
//  ArchiveCompleteVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/20.
//

import UIKit

import SnapKit
import Then
import Lottie

final class ArchiveCompleteVC: UIViewController {
    
    // MARK: - UI Components
    
    private let checkAnimationView: LottieAnimationView = .init(name: "ToMECheck")

    private let titleLabel = UILabel().then {
        $0.font = .subTitle1
        $0.textColor = .font1
        $0.text = "아카이브가 저장되었어요."
    }
        
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("d")
        setUI()
        setLayout()
        setAnimation()
    }
}

// MARK: - Methods

extension ArchiveCompleteVC {
    private func setAnimation() {
        self.checkAnimationView.loopMode = .playOnce
    }
}

// MARK: - UI & Layout

extension ArchiveCompleteVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(checkAnimationView, titleLabel)
        
        checkAnimationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(79)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkAnimationView.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
        }
    }
}
