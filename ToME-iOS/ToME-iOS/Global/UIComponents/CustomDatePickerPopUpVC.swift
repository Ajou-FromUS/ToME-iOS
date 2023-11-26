//
//  CustomDatePickerPopUpVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then

final class CustomDatePickerPopUpVC: UIViewController {
    
    // MARK: - Properties

    private var completionClosure: ((Date) -> Void)?
    
    // MARK: - UI Components
    
    private lazy var containerView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        $0.layer.applyShadow(color: UIColor(hex: "#ABABAB"), alpha: 0.25, x: 0, y: 0, blur: 12, spread: 0)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .font1
        $0.font = .body1
    }
    
    private let closeButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.homeIcPopupClose, for: .normal)
    }
    
    private lazy var completeButton = CustomButton(title: "완료하기", type: .fillWithBlue)
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale(identifier: "ko_KR") // 한국어로 설정
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        return picker
    }()
    
    // MARK: - initialization
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
}

// MARK: - @objc Function

extension CustomDatePickerPopUpVC {
    @objc private func closeButtonDidTap() {
        self.dismiss(animated: false)
    }
    
    @objc private func completeButtonDidTap() {
        let selectedDate = datePicker.date
        completionClosure?(selectedDate)
        self.dismiss(animated: false)
    }
}

// MARK: - Methods

extension CustomDatePickerPopUpVC {
    private func setAddTarget() {
        self.closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        self.completeButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }
    
    func setCompletionClosure(_ closure: @escaping (Date) -> Void) {
        completionClosure = closure
    }
}

// MARK: - UI & Layout

extension CustomDatePickerPopUpVC {
    private func setUI() {
        self.containerView.backgroundColor = .white
        view.backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    private func setLayout() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(415)
        }
        
        containerView.addSubviews(titleLabel, closeButton, datePicker, completeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(27)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(27)
            make.width.height.equalTo(20)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(58)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(58)
        }
        
        datePicker.snp.makeConstraints { make in
            make.bottom.equalTo(completeButton.snp.top).offset(-37)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(150)
        }
    }
}
