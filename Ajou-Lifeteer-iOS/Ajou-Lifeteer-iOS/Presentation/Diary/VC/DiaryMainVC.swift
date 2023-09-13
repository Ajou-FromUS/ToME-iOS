//
//  DiaryMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class DiaryMainVC: UIViewController {
    
    // MARK: - Properties
    
    private var calendar = Calendar.current
    private let currentDate = Date()
    private lazy var currentYear: Int = calendar.component(.year, from: currentDate)
    private lazy var currentMonth: Int = calendar.component(.month, from: currentDate)
    private lazy var currentDay: Int = calendar.component(.day, from: currentDate)

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("일기")
    
    private let characterImageView = UIImageView()
    
    private lazy var messageBubbleView = CustomMessageBubbleView(message: "오늘은\n무슨 일 있었어?", type: .onlyMessage)
    
    private lazy var emojiBubbleView = CustomMessageBubbleView(message: "\u{1F618}", type: .emoji)
    
    private let calendarImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgCalender
    }
    
    private lazy var calendarYearLabel = UILabel().then {
        $0.text = String(currentYear)
        $0.font = .body1
        $0.textColor = .mainColor
    }
    
    private lazy var calendarMonthLabel = UILabel().then {
        $0.text = String(currentMonth)
        $0.font = .body2
        $0.textColor = .font1
    }
    
    private lazy var calendarDayLabel = UILabel().then {
        $0.text = String(currentDay)
        $0.font = .body3
        $0.textColor = .font1
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension DiaryMainVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        calendarImageView.backgroundColor = .mainColor
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, characterImageView, calendarImageView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(60)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(130)
            make.height.equalTo(190)
        }
        
        calendarImageView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(132)
            make.centerX.equalToSuperview()
            make.width.equalTo(163)
            make.height.equalTo(208)
        }
    
        setCalendarLayout()
    }
    
    private func setCalendarLayout() {
        calendarImageView.addSubviews(calendarYearLabel, calendarMonthLabel, calendarDayLabel)
        
        calendarYearLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
        }
        
        calendarMonthLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarYearLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        calendarDayLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarMonthLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
}
