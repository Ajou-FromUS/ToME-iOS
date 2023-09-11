//
//  CustomPopUpVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/12.
//

import UIKit

import SnapKit
import Then

@frozen
enum popUpType {
    case todaysMission
}

final class CustomPopUpVC: UIViewController {

    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .title1
        $0.textColor = .font1
    }
    
    
    // MARK: - initialization
    
    init(title: String, type: popUpType) {
        super.init(nibName: nil, bundle: nil)
        setLayout(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: - UI & Layout

extension CustomPopUpVC {
    private func setUI() {
        
    }
    
    private func setLayout() {
        
    }
}
