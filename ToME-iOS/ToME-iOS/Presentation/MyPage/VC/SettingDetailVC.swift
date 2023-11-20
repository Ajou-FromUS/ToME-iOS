//
//  SettingDetailVC.swift
//  ToME-iOS
//
//  Created by 몽이 누나 on 11/20/23.
//

import UIKit

import SnapKit
import Then

final class SettingDetailVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitleWithBackButton)
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar(wantsToHide: true)
    }
}

// MARK: - Methods

extension SettingDetailVC {
    func setData(title: String) {
        self.naviBar.setTitle(title)
        
        if title == "문의하기" {
            setInquiryViewLayout()
        }
    }
}

// MARK: - UI & Layout

extension SettingDetailVC {
    private func setUI() {
        view.backgroundColor = .myPageBackground
    }
    
    private func setLayout() {
        view.addSubviews(naviBar)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
    }
    
    private func setInquiryViewLayout() {
        let inquiryView = InquiryView()
        
        view.addSubview(inquiryView)
        
        inquiryView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(27)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(59)
        }
    }
}
