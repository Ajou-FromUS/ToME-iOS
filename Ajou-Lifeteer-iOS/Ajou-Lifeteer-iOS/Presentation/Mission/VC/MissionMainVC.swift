//
//  MissionMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

import SnapKit
import Then
import Lottie

final class MissionMainVC: UIViewController {
    
    
    
    // MARK: - Properties
    
    let cellHeight = 94 // 각 셀의 높이
    let spacing = 10 // 간격의 높이

    var missionList: [MissionModel] = [
        MissionModel(missionType: 0, missionTitle: "나무 사진찍기"),
        MissionModel(missionType: 1, missionTitle: "50db까지 소리 지르기"),
        MissionModel(missionType: 2, missionTitle: "오늘의 감사일기 적어보기")
    ]
    
    let customBlur = CustomBlur.shared
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
    /// top 부분, 미션 수행 개수를 적어서 넣어주기
    private lazy var currentMissionCompleteView = CurrentMissionCompleteView(numberOfCompleteMission: 1)
    
    private lazy var missionTableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
    }
    
    private let backgroundLottieView: LottieAnimationView = .init(name: "background")
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setDeleagate()
        setDataSource()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar(wantsToHide: false)
        setAnimation()
    }
}

// MARK: - Methods

extension MissionMainVC {
    private func setDataSource() {
        missionTableView.dataSource = self
    }
    
    private func setDeleagate() {
        missionTableView.delegate = self
    }
    
    private func registerCell() {
        missionTableView.register(MissionTableViewCell.self,
                                  forCellReuseIdentifier: MissionTableViewCell.className
        )
    }
    
    private func setAnimation() {
        backgroundLottieView.play()
        backgroundLottieView.loopMode = .loop
    }
}

// MARK: - UI & Layout

extension MissionMainVC {
    private func setUI() {
        view.backgroundColor = .white
        missionTableView.backgroundColor = .clear
        customBlur.addBlurEffect(to: backgroundLottieView)
        customBlur.setBlurIntensity(to: backgroundLottieView, intensity: 1)
    }
    
    private func setLayout() {
        view.addSubviews(backgroundLottieView)
        
        backgroundLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubviews(naviBar, currentMissionCompleteView, missionTableView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        currentMissionCompleteView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        
        missionTableView.snp.makeConstraints { make in
            make.top.equalTo(currentMissionCompleteView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(missionList.count * 94 + 20)
        }
    }
}

// MARK: - UITableViewDelegate

extension MissionMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight + spacing)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MissionTableViewCell else { return }
        guard let selectedRecords = tableView.indexPathsForSelectedRows else { return }
            
        // 미션 상세 페이지로 이동
        let missionDetailVC = MissionDetailVC()
        missionDetailVC.setData(missionType: self.missionList[indexPath.row].missionType, missionTitle: self.missionList[indexPath.row].missionTitle)
        self.navigationController?.fadeTo(missionDetailVC)
    }
}

// MARK: - UITableViewDataSource

extension MissionMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missionList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let missionTableViewCell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.className, for: indexPath)
                    as? MissionTableViewCell else { return UITableViewCell() }
        missionTableViewCell.setData(model: missionList[indexPath.row])
        missionTableViewCell.backgroundColor = .clear
        missionTableViewCell.selectionStyle = .none
        return missionTableViewCell
    }
    
}
