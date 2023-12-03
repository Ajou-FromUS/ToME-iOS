//
//  MissionProceedVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/7/23.
//

import UIKit

import SnapKit
import Then
import Lottie
import Moya

final class MissionProceedVC: UIViewController {
    
    // MARK: - Provider
    
    private let missionProvider = Providers.missionProvider
    
    // MARK: - Properties
    
    var missionType = Int()
    
    var id = Int()
    
    var content = String()
    
    private let decibelManager = ToMEDecibelMananger.shared
    
    private let customBlur = CustomBlur.shared
            
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
    private let middleLabel = UILabel().then {
        $0.text = "오늘의 미션을 수행해 보세요."
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.disabled2.cgColor
    }
    
    private let missionImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
    }
    
    private let missionTypeLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .font3
    }
    
    private let horizontalDevidedView = UIView()
    
    var missionTitleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    private lazy var circularDecibelProgressView = CircularMissionProgressView()
    
    private let missionSubLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .newBody2
        $0.textColor = .font1
        $0.text = "데시벨을 측정하고 있어요.\n마음껏 소리 지르세요!"
        $0.setLineSpacing(lineSpacing: 8)
        $0.textAlignment = .center
    }
    
    var decibelLabel = UILabel().then {
        $0.font = .title1
        $0.textColor = .font1
    }
    
    private let dBLabel = UILabel().then {
        $0.font = .title4
        $0.textColor = .font1
        $0.text = "db"
    }
    
    private lazy var decibelValueStackView = UIStackView(
        arrangedSubviews: [decibelLabel, dBLabel]
    ).then {
        $0.spacing = 3
        $0.alignment = .bottom
    }
    
    private lazy var missionTextView = ToMeTextViewManager(placeholder: "이곳을 클릭하여 작성하세요.\n최대 85자까지 작성할 수 있어요.", maxCount: 85).then {
        $0.isEditable = true
    }
    
    private let textSubLabel = UILabel().then {
        $0.text = "오늘 주어진 질문에 대해서 답을 적어보세요."
        $0.font = .body2
        $0.textColor = .font2
    }
    
    var completeMissionButton = CustomButton(title: "티오에게 보여주기",
                                             type: .fillWithBlueAndImage)
        .setImage(image: ImageLiterals.toBtnImage, disabledImage: ImageLiterals.toBtnImageDisabled).then {
            $0.setEnabled(false)
        }
    
    var backButton = CustomButton(title: "다른 미션 보러가기", type: .fillWithGreyAndImage)
                                                        .setImage(image: ImageLiterals.backBtnImage, disabledImage: nil)
    
    private let backgroundLottieView: LottieAnimationView = .init(name: "background")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setCompleteButtonEnabled()
        setMission()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면을 빠져나가면 데시벨 모니터링 중단
        decibelManager.stopMonitoringDecibels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAnimation()
    }
}

// MARK: - @objc Function

extension MissionProceedVC {
    @objc private func popToPreviousVC() {
        // 이동하고자 하는 이전 페이지의 인덱스를 찾거나 해당 뷰 컨트롤러를 가져옵니다.
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count >= 3 { // 이전 페이지가 2개 이상 있는 경우
                let previousViewController = viewControllers[viewControllers.count - 3]
                self.navigationController?.popToViewController(previousViewController, animated: false)
            }
        }
    }
    
    @objc private func completeMissionButtonDidTap() {
        if missionType == 0 {   // 텍스트 미션일 경우
            self.content = self.missionTextView.text
        }
        
        self.patchTextOrDecibelMissionUpdate()
        
        let missionCompleteVC = MissionCompleteVC()
        missionCompleteVC.setData(missionType: self.missionType)
        self.navigationController?.fadeTo(missionCompleteVC)
    }
}

// MARK: - Methods

extension MissionProceedVC {
    func setData(missionType: Int, missionTitle: String, id: Int) {
        if missionType == 2 {
            self.missionTypeLabel.text = "데시벨 미션"
            self.missionImageView.image = ImageLiterals.missionImgDecibel
        } else {
            self.missionTypeLabel.text = "텍스트 미션"
            self.missionImageView.image = ImageLiterals.missionImgText
        }
        
        self.missionType = missionType
        self.missionTitleLabel.text = missionTitle
        missionTitleLabel.lineBreakMode = .byWordWrapping
        missionTitleLabel.setLineSpacing(lineSpacing: 5)
        self.id = id
    }
    
    func setAddTarget() {
        self.completeMissionButton.addTarget(self, action: #selector(completeMissionButtonDidTap), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
    }
    
    private func setMission() {
        if missionType == 2 { // 데시벨 미션일 경우
            decibelManager.requestAudioAuthorization()
            setDecibelVisualization()
        }
    }
    
    private func setCompleteButtonEnabled() {
        missionTextView.onTextChange = { isTextFilled in
            self.completeMissionButton.isEnabled = isTextFilled
        }

    }
    
    private func setDecibelVisualization() {
        // 데시벨 측정 시작
        decibelManager.startMonitoringDecibels()
        // 0.5초마다 데시벨 값을 업데이트하고 ProgressView에 반영
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let decibelValue = self.decibelManager.returnAudioLevel()
            self.updateCircularDecibelProgressView(withDecibels: decibelValue)
            self.updateDecibelStackView(withDecibels: decibelValue)
            if decibelValue >= 50 { self.setCompleteDecibelMission() }
        }
    }
    
    // 데시벨에 따른 원형 그래프 업데이트
    private func updateCircularDecibelProgressView(withDecibels decibels: Float) {
        // Ensure the decibel level is within the valid range (0 to 50)
        let normalizedDecibels = min(max(decibels, 0), 50)
        // Calculate the progress as a percentage
        let progressPercentage = normalizedDecibels / 50.0
        // Update the progress property of the CircularProgressView
        circularDecibelProgressView.progress = CGFloat(progressPercentage)
    }
    
    // 데시벨에 따른 StackView 업데이트
    private func updateDecibelStackView(withDecibels decibels: Float) {
        let normalizedDecibels = min(max(decibels, 0), 50)
        self.decibelLabel.text = String(Int(normalizedDecibels))
    }

    // 데시벨을 달성했을 경우
    private func setCompleteDecibelMission() {
        self.completeMissionButton.setEnabled(true)
        self.completeMissionButton.isHidden = false
        self.backButton.isHidden = false
    }
    
    private func setAnimation() {
        backgroundLottieView.play()
        backgroundLottieView.loopMode = .loop
    }
}

// MARK: - UI & Layout

extension MissionProceedVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        self.containerView.backgroundColor = .disabled2.withAlphaComponent(0.6)
        self.horizontalDevidedView.backgroundColor = .font3
        self.circularDecibelProgressView.backgroundColor = .clear
        customBlur.addBlurEffect(to: backgroundLottieView)
        customBlur.setBlurIntensity(to: backgroundLottieView, intensity: 1)
    }
    
    private func setLayout() {
        view.addSubviews(backgroundLottieView)
        
        backgroundLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubviews(naviBar, middleLabel, containerView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        middleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(180)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.top.equalTo(middleLabel.snp.bottom).offset(31)
        }
        
        containerView.addSubviews(missionImageView, missionTypeLabel, horizontalDevidedView, missionTitleLabel)
        
        missionImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(21)
            make.width.height.equalTo(67)
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(missionImageView.snp.top).inset(4)
            make.leading.equalTo(missionImageView.snp.trailing).offset(15)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(missionTypeLabel.snp.bottom).offset(7)
            make.leading.equalTo(missionTypeLabel.snp.leading)
            make.width.equalTo(97)
            make.height.equalTo(0.5)
        }
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(10)
            make.leading.equalTo(missionTypeLabel.snp.leading)
            make.trailing.equalToSuperview().inset(27)
        }
       
        if missionType == 2 {
            setDecibelMissionLayout()
        } else {
            setTextMisisonLayout()
        }
        
        view.addSubviews(completeMissionButton, backButton)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
        
        completeMissionButton.snp.makeConstraints { make in
            make.bottom.equalTo(backButton.snp.top).offset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
    }
    
    private func setDecibelMissionLayout() {
        self.completeMissionButton.isHidden = true
        self.backButton.isHidden = true
        
        containerView.addSubviews(circularDecibelProgressView, missionSubLabel, decibelValueStackView)
        
        circularDecibelProgressView.snp.makeConstraints { make in
            make.top.equalTo(missionTitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(97)
            make.height.equalTo(circularDecibelProgressView.snp.width)
        }
        
        missionSubLabel.snp.makeConstraints { make in
            make.top.equalTo(circularDecibelProgressView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(missionSubLabel.snp.bottom).offset(40)
        }
        
        decibelValueStackView.snp.makeConstraints { make in
            make.center.equalTo(circularDecibelProgressView.snp.center)
        }
    }
    
    private func setTextMisisonLayout() {
        containerView.addSubviews(textSubLabel, missionTextView)
        
        textSubLabel.snp.makeConstraints { make in
            make.top.equalTo(missionImageView.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
        }
        
        missionTextView.snp.makeConstraints { make in
            make.top.equalTo(textSubLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(166)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(missionTextView.snp.bottom).offset(40)
        }
    }
}

// MARK: - Network

extension MissionProceedVC {
    private func patchTextOrDecibelMissionUpdate() {
        LoadingIndicator.showLoading()
        missionProvider.request(.patchTextOrDecibelMissionUpdate(id: self.id, content: self.content)) { [weak self] response in
            guard let self = self else { return }
            LoadingIndicator.hideLoading()
            switch response {
            case .success(let result):
                let status = result.statusCode
                if 200..<300 ~= status {
                    do {
                        print("미션 수행 완료")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if status >= 400 {
                    print("400 error")
                    self.showNetworkFailureToast()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.showNetworkFailureToast()
            }
        }
    }
}
