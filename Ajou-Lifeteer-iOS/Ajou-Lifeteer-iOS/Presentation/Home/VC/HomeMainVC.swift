//
//  HomeMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class HomeMainVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .home).setUserName("몽이누나")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension HomeMainVC {
    private func setUI() {
        view.backgroundColor = .blue
    }
    
    private func setLayout() {
        view.addSubviews(naviBar)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(179)
        }
    }
}
