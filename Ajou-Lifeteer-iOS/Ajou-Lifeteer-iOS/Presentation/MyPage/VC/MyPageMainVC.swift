//
//  MyPageMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/26.
//

import UIKit

import SnapKit
import Then

final class MyPageMainVC: UIViewController {
    
    // MARK: - UI Components
    
    private let backButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.mypageIcBack, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .title1
        $0.textColor = .font1
        $0.text = "마이페이지"
    }
        
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension MyPageMainVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        
    }
}
