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
    
    // MARK: - Properties

    private let settingList: [String] = ["알림설정", "문의하기", "계정 설정", "개인정보처리방침"]
    
    let cellHeight = 53 // 각 셀의 높이
    let spacing = 12 // 간격의 높이
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("마이페이지")
    
    private let myRecordButton = UIButton(type: .custom).then {
        $0.setTitle("내 미션 기록보기", for: .normal)
        $0.setTitleColor(.font1, for: .normal)
        $0.titleLabel?.font = .subTitle2
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 0)
        $0.setBackgroundColor(.sub2, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    private let horizontalDividedView = UIView()
    
    private let settingLabel = UILabel().then {
        $0.text = "환경설정"
        $0.textColor = .font1
        $0.font = .body1
    }
    
    private lazy var settingTableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    private lazy var versionString = UILabel().then {
        guard let appVersion = appVersion else { return }
        $0.text = "ver. \(appVersion)"
        $0.font = .body2
        $0.textColor = .font3
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUI()
        setLayout()
        setDeleagate()
        setDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar(wantsToHide: false)
    }
}

// MARK: - Methods

extension MyPageMainVC {
    private func setDataSource() {
        settingTableView.dataSource = self
    }
    
    private func setDeleagate() {
        settingTableView.delegate = self
    }
    
    private func registerCell() {
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.className)
    }
}

// MARK: - UI & Layout

extension MyPageMainVC {
    private func setUI() {
        view.backgroundColor = .myPageBackground
        self.settingTableView.backgroundColor = .clear
        self.horizontalDividedView.backgroundColor = .sub2
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, myRecordButton, horizontalDividedView, settingLabel,
                         settingTableView, versionString)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        myRecordButton.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(61)
        }
        
        horizontalDividedView.snp.makeConstraints { make in
            make.top.equalTo(myRecordButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(0.5)
        }
        
        settingLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDividedView.snp.bottom).offset(18)
            make.leading.equalToSuperview().inset(27)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(settingLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(settingList.count * cellHeight + (settingList.count - 1) * spacing)
        }
        
        versionString.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension MyPageMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight + spacing)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell else { return }
        guard let selectedRecords = tableView.indexPathsForSelectedRows else { return }
            
        // 환경설정 상세 페이지로 이동
        let settingDetailVC = SettingDetailVC()
        settingDetailVC.setData(title: settingList[indexPath.row])
        self.navigationController?.fadeTo(settingDetailVC)
    }
}

// MARK: - UITableViewDataSource

extension MyPageMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingTableViewCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.className, for: indexPath)
                    as? SettingTableViewCell else { return UITableViewCell() }
        settingTableViewCell.setData(title: settingList[indexPath.row])
        settingTableViewCell.backgroundColor = .clear
        settingTableViewCell.selectionStyle = .none
        return settingTableViewCell
    }
}
