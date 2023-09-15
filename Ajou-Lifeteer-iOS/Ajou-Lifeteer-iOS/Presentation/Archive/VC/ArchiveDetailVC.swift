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
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .withoutBackground).setTitle("아카이브")
    
    private lazy var saveButton = CustomButton(title: "저장 완료하기", type: .fillWithBlue).then {
        $0.isEnabled = false
    }
    
    private let questionNumberLabel = UILabel().then {
        $0.font = .questionNumber
        $0.textColor = .mainColor
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension ArchiveDetailVC {
    private func setUI() {
        view.backgroundColor = .systemGray
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, saveButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(52)
        }
    }
}
