//
//  ArchiveMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class ArchiveMainVC: UIViewController {

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("아카이브")
    
    private let characterImageView = UIImageView()
    
    private lazy var messageBubbleView = CustomMessageBubbleView(message: "나를\n돌아볼 시간...", type: .onlyMessage)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension ArchiveMainVC {
    private func setUI() {
        view.backgroundColor = .black
        characterImageView.backgroundColor = .mainColor
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, characterImageView, messageBubbleView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(87)
            make.centerX.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(181)
        }
        
        messageBubbleView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.top).offset(-34)
            make.trailing.equalTo(characterImageView.snp.trailing).offset(76)
            make.width.equalTo(95)
            make.height.equalTo(50)
        }
    }
}
