//
//  MissionDetailVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit

import SnapKit
import Then
import Lottie
import Moya

final class MissionDetailVC: UIViewController {
    
    // MARK: - Provider
    
    private let missionProvider = Providers.missionProvider
    
    // MARK: - Properties

    private var photoManager: ToMEPhotoManager?
    
    let customBlur = CustomBlur.shared
    
    var missionType = Int()
    
    var id = Int()
    
    var startMissionButtonTitle: String = "미션 수행하러 가기"
    
    var backButtonTitle: String = "다른 미션 보러가기"
    
    var completedMissionCount = Int()
    
    var imageData = NSData()
            
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("미션")
    
    /// top 부분, 미션 수행 개수를 적어서 넣어주기
    private lazy var currentMissionCompleteView = CurrentMissionCompleteView(numberOfCompleteMission: completedMissionCount)
    
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
    
    private let missionTitleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    private let middleLabel = UILabel().then {
        $0.text = "오늘의 미션을 수행해 보세요."
        $0.font = .newBody3
        $0.textColor = .font1
    }
    
    var startMissionButton = CustomButton(title: "미션 수행하러 가기", type: .fillWithBlueAndImage)
    
    var showToToButton = CustomButton(title: "티오에게 보여주기", type: .fillWithBlueAndImage).setImage(image: ImageLiterals.toBtnImage, disabledImage: ImageLiterals.toBtnImageDisabled)
    
    var backButton = CustomButton(title: "다른 미션 보러가기", type: .fillWithGreyAndImage)
        .setImage(image: ImageLiterals.backBtnImage, disabledImage: nil)
    
    private let backgroundLottieView: LottieAnimationView = .init(name: "background")

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTabBar(wantsToHide: true)
        setUI()
        setLayout()
        setAddTarget()
        // PhotoManager 초기화
        photoManager = ToMEPhotoManager(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAnimation()
    }
}

// MARK: - @objc Function

extension MissionDetailVC {
    @objc private func popToPreviousVC() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func startPhotoMissionButtonDidTap() {
        pushToPhotoAlertController()
        // crop이 끝난 사진을 missionImageView의 image로 설정
        photoManager?.didFinishCropping = { croppedImage in
            // 버튼을 완료 버튼으로 바꿔주기 위한 부분
            self.startMissionButton.isHidden = true
            self.setShowToToButtonLayout()
            
            // croppedImage를 Data로 변환
            guard let imageData = croppedImage.jpegData(compressionQuality: 0.8) else {
                print("Failed to convert image to data.")
                return
            }
            
            self.imageData = imageData as NSData  // UIImage를 NSData로 변환
                        
            self.missionImageView.image = croppedImage
            self.missionImageView.layer.cornerRadius = 10
            self.currentMissionCompleteView.isHidden = true
            
            self.backButton.setTitle("dfadfqerqerwer", for: .application)
            
            self.view.addSubview(self.middleLabel)
            self.middleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(self.containerView.snp.top).offset(-20)
            }

            print(croppedImage)
        }
        
        self.backButtonTitle = "zzzz"
        self.backButton.changeTitle(string: self.backButtonTitle)
    }
    
    @objc private func startOtherButtonDidTap() {
        let missionProceedVC = MissionProceedVC()
        missionProceedVC.setData(missionType: self.missionType,
                                 missionTitle: self.missionTitleLabel.text ?? String(),
                                 id: self.id)
        self.navigationController?.fadeTo(missionProceedVC)
    }
    
    @objc private func showToToButtonDidTap() {
//        self.patchImageMissionUpdate()
        let missionCompleteVC = MissionCompleteVC()
        missionCompleteVC.setData(missionType: self.missionType)
        self.navigationController?.fadeTo(missionCompleteVC)
    }
}

// MARK: - Methods

extension MissionDetailVC {
    func setData(missionType: Int, missionTitle: String, completedMissionCount: Int, id: Int) {
        if missionType == 0 {
            self.missionTypeLabel.text = "텍스트 미션"
            self.missionImageView.image = ImageLiterals.missionImgTextRectangle
            self.startMissionButton.setImage(image: ImageLiterals.missionIcTextFill, disabledImage: nil)
        } else if missionType == 1 {
            self.missionTypeLabel.text = "찰칵 미션"
            self.missionImageView.image = ImageLiterals.missionImgPhotoRectangle
            self.startMissionButton.setImage(image: ImageLiterals.gallaryBtnImageFill, disabledImage: nil)
        } else {
            self.missionTypeLabel.text = "데시벨 미션"
            self.missionImageView.image = ImageLiterals.missionImgDecibelRectangle
            self.startMissionButton.setImage(image: ImageLiterals.missionIcDecibelFill, disabledImage: nil)
        }
        self.missionType = missionType
        self.missionTitleLabel.text = missionTitle
        missionTitleLabel.lineBreakMode = .byWordWrapping
        missionTitleLabel.setLineSpacing(lineSpacing: 3)
        self.completedMissionCount = completedMissionCount
        self.id = id
    }
    
    func setAddTarget() {
        if self.missionType == 1 {
            self.startMissionButton.addTarget(self, action: #selector(startPhotoMissionButtonDidTap), for: .touchUpInside)
        } else {
            self.startMissionButton.addTarget(self, action: #selector(startOtherButtonDidTap), for: .touchUpInside)
        }
        
        self.showToToButton.addTarget(self, action: #selector(showToToButtonDidTap), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
    }
    
    private func setAnimation() {
        backgroundLottieView.play()
        backgroundLottieView.loopMode = .loop
    }
    
    func pushToPhotoAlertController() {
        let photoAlertController = UIAlertController(title: "사진 업로드", message: nil, preferredStyle: .actionSheet)
        // 카메라 권한 확인 및 카메라 열기
        let photoAction = UIAlertAction(title: "사진 선택하기", style: .default, handler: {(_: UIAlertAction!) in
            self.photoManager?.requestAlbumAuthorization()
        })
        let cameraAction = UIAlertAction(title: "카메라로 촬영하기", style: .default, handler: {(_: UIAlertAction!) in
            self.photoManager?.requestCameraAuthorization()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [ photoAction, cameraAction, cancelAction ].forEach { photoAlertController.addAction($0) }
        present(photoAlertController, animated: true, completion: nil)
    }
}

// MARK: - UI & Layout

extension MissionDetailVC {
    private func setUI() {
        view.backgroundColor = .systemGray
        self.containerView.backgroundColor = .disabled2.withAlphaComponent(0.6)
        self.horizontalDevidedView.backgroundColor = .font3
        customBlur.addBlurEffect(to: backgroundLottieView)
        customBlur.setBlurIntensity(to: backgroundLottieView, intensity: 1)
    }
    
    private func setLayout() {
        view.addSubviews(backgroundLottieView)
        
        backgroundLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubviews(naviBar, currentMissionCompleteView, containerView)
        
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
        
        setContainerViewLayout()
        
        view.addSubviews(startMissionButton, backButton)
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
        
        startMissionButton.snp.makeConstraints { make in
            make.bottom.equalTo(backButton.snp.top).offset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
    }
    
    private func setContainerViewLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(currentMissionCompleteView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
        }
        
        containerView.addSubviews(missionImageView, missionTypeLabel, horizontalDevidedView, missionTitleLabel)
        
        missionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(missionImageView.snp.width).multipliedBy(0.7)
        }
        
        missionTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(missionImageView.snp.leading)
            make.top.equalTo(missionImageView.snp.bottom).offset(14)
        }
        
        horizontalDevidedView.snp.makeConstraints { make in
            make.top.equalTo(missionTypeLabel.snp.bottom).offset(8)
            make.leading.equalTo(missionImageView.snp.leading)
            make.width.equalTo(97)
            make.height.equalTo(0.5)
        }
        
        missionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDevidedView.snp.bottom).offset(10)
            make.leading.equalTo(missionImageView.snp.leading)
            make.trailing.equalTo(missionImageView.snp.trailing)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(missionTitleLabel.snp.bottom).offset(20)
        }
    }
    
    private func setShowToToButtonLayout() {
        view.addSubview(showToToButton)
        
        showToToButton.snp.makeConstraints { make in
            make.bottom.equalTo(backButton.snp.top).offset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            make.height.equalTo(53)
        }
    }
}

// MARK: - Network

extension MissionDetailVC {
    private func patchImageMissionUpdate() {
        LoadingIndicator.showLoading()
        missionProvider.request(.patchImageMissionUpdate(id: self.id, missionImage: self.imageData)) { [weak self] response in
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
