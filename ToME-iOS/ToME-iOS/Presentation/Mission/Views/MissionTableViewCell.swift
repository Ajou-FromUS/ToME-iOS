//
//  MissionTableViewCell.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

import SnapKit
import Then

class MissionTableViewCell: UITableViewCell {

    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.disabled2.cgColor
    }
    
    private let missionImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
    }
    
    private let missionTypeLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .font3
    }
    
    private let horizontalDevidedView = UIView()
    
    private let missionTitleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .newBody3
        $0.textColor = .font1
        
    }
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionTableViewCell {
    func setData(model: MissionList, idList: [Int], isCompleted: Bool) {
        if model.type == 0 {
            missionTypeLabel.text = "텍스트 미션"
            missionImageView.image = ImageLiterals.missionImgText
        } else if model.type == 1 {
            missionTypeLabel.text = "찰칵 미션"
            missionImageView.image = ImageLiterals.missionImgPhoto
        } else if model.type == 2 {
            missionTypeLabel.text = "데시벨 미션"
            missionImageView.image = ImageLiterals.missionImgDecibel
        } else {    // model.type == -1로 넘어오는 경우, 즉 null
            missionTypeLabel.text = "티오와 대화하여 오늘의 미션을 받아보세요."
            self.isUserInteractionEnabled = false
        }
        
        missionTitleLabel.text = model.title
        missionTitleLabel.lineBreakMode = .byWordWrapping
        missionTitleLabel.setLineSpacing(lineSpacing: 3)
        setLayout(missionType: model.type)
        
        if isCompleted {
            isMissionCompleted()
        }
    }
    
    func isMissionCompleted() {
        self.isUserInteractionEnabled = false
        self.missionImageView.image = ImageLiterals.missionImgCompletde
        self.containerView.backgroundColor = .sub1
        self.containerView.layer.borderColor = UIColor.mainColor.cgColor
        self.containerView.layer.borderWidth = 1
        self.missionTypeLabel.textColor = .font4
        self.horizontalDevidedView.backgroundColor = .font4
    }
}

// MARK: - UI & Layout

extension MissionTableViewCell {
    private func setUI() {
        self.containerView.backgroundColor = .disabled2.withAlphaComponent(0.6)
        self.horizontalDevidedView.backgroundColor = .font3
    }
    
    private func setLayout(missionType: Int) {
        self.addSubviews(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(94)
            
        }
                
        missionType == -1 ? nullMissionLayout() : existingMissionLayout()
    }
    
    private func nullMissionLayout() {
        containerView.addSubviews(missionTitleLabel, missionTypeLabel)
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    private func existingMissionLayout() {
        containerView.addSubviews(missionImageView, missionTypeLabel, horizontalDevidedView, missionTitleLabel)
        
        missionImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
            make.width.height.equalTo(67)
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17)
            make.leading.equalTo(missionImageView.snp.trailing).offset(15)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(missionTypeLabel.snp.bottom).offset(5)
            make.leading.equalTo(missionTypeLabel.snp.leading)
            make.height.equalTo(0.5)
            make.width.equalTo(97)
        }
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(6)
            make.leading.equalTo(missionTypeLabel.snp.leading)
            make.trailing.equalToSuperview().inset(19)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
}
