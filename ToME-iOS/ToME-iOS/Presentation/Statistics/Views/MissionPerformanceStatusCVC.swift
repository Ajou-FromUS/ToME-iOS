//
//  MissionPerformanceStatusCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then

final class MissionPerformanceStatusCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    let cellIdentifier = "ContributeCalendarCell"

    private var missionPerformanceList = [Int]()

    // MARK: - UI Components
    
    private let missionPerformanceStatusLabel = UILabel().then {
        $0.text = "미션 수행 현황"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
    
    private lazy var performanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let missionPerformanceSubLabel = UILabel().then {
        $0.text = "지난 달에 비해 접속한 횟수가 증가했어요!"
        $0.font = .body2
        $0.textColor = .font2
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        register()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionPerformanceStatusCVC {
    func setData(list: [Int]) {
        self.missionPerformanceList = list
    }
    
    private func register() {
        self.performanceCollectionView.register(UICollectionViewCell.self,
                                                forCellWithReuseIdentifier: cellIdentifier)
    }
    
    // GitHub contribute 수에 따른 배경색 지정
    func missionPerformanceColor(_ count: Int) -> UIColor {
        switch count {
        case 0:
            return .disabled2
        case 1:
            return .sub2
        case 2:
            return .sub1
        case 3:
            return .mainColor
        default:
            return .clear
        }
    }
}

// MARK: - UI & Layout

extension MissionPerformanceStatusCVC {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubviews(missionPerformanceStatusLabel, performanceCollectionView, missionPerformanceSubLabel)
        
        missionPerformanceStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(27)
        }
        
        performanceCollectionView.snp.makeConstraints { make in
            make.top.equalTo(missionPerformanceStatusLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(80)
        }
        
        missionPerformanceSubLabel.snp.makeConstraints { make in
            make.top.equalTo(performanceCollectionView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MissionPerformanceStatusCVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missionPerformanceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                
        // 셀의 배경색 설정
        let missionPerformanceCount = missionPerformanceList[indexPath.item]
        cell.backgroundColor = missionPerformanceColor(missionPerformanceCount)
        cell.layer.cornerRadius = 3
        
        return cell
    }
}
