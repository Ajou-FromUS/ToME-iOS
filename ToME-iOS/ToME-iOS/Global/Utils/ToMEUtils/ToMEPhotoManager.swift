//
//  ToMEPhotoManager.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/6/23.
//

import UIKit
import AVFoundation
import Photos

import Mantis

class ToMEPhotoManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    private var imagePicker = UIImagePickerController()
    private var vc: UIViewController?
    var options = PHImageRequestOptions()   // icloud에서 사진 가져올 경우 생기는 오류
    var didFinishCropping: ((UIImage) -> Void)?
    
    // MARK: - init

    init(vc: UIViewController) {
        super.init()
        self.vc = vc
        self.imagePicker.delegate = self
        options.isNetworkAccessAllowed = true
    }
    
    // MARK: - Methods

    // 카메라 접근 권한 확인 및 처리
    func requestCameraAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("권한 허용")
                self.openCamera()
            } else {
                print("권한 거부")
                self.showAlertForPermission("카메라")
            }
        }
    }

    // 앨범 접근 권한 확인 및 처리
    func requestAlbumAuthorization() {
        DispatchQueue.main.async {
            switch PHPhotoLibrary.authorizationStatus() {
            case .denied:
                print("거부")
                self.showAlertForPermission("앨범")
            case .authorized:
                print("허용")
                self.openPhotoLibrary()
            case .notDetermined, .restricted:
                print("아직 결정하지 않은 상태")
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        self.openPhotoLibrary()
                    } else {
                        self.dismissImagePicker()
                    }
                }
            default:
                break
            }
        }
    }

    // 권한을 거부했을 때 띄어주는 Alert 함수
    func showAlertForPermission(_ type: String) {
        if let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            let alertVC = UIAlertController(
                title: "설정",
                message: "\(appName)이(가) \(type) 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
                preferredStyle: .alert
            )
            let cancelAction = UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(confirmAction)
            vc?.present(alertVC, animated: true, completion: nil)
        }
    }

    // 아이폰에서 카메라에 접근하는 함수
    private func openCamera() {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.modalPresentationStyle = .currentContext
                self.vc?.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("카메라에 접근할 수 없습니다.")
            }
        }
    }

    // 앨범에서 사진을 선택했을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, 
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("Selected image: \(image)")
            cropImageAction(image)
        }
        dismissImagePicker()
    }

    // 이미지 피커를 닫는 메서드
    private func dismissImagePicker() {
        vc?.dismiss(animated: true, completion: nil)
    }

    // 앨범 열기
    private func openPhotoLibrary() {
        DispatchQueue.main.async {
            self.imagePicker.sourceType = .photoLibrary
            self.vc?.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // 이미지 크롭 액션 실행
    func cropImageAction(_ image: UIImage) {
        // 이미지 크롭을 시작합니다.
        let cropVC = Mantis.cropViewController(image: image)
        cropVC.delegate = self
        cropVC.config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1.25)
        vc?.navigationController?.pushViewController(cropVC, animated: true)
        // 이미지 크롭 액션이 완료되면 iCloud에서 이미지를 가져옵니다.
    }
}

// MARK: - CropViewControllerDelegate

extension ToMEPhotoManager: CropViewControllerDelegate {
    /// 이미지 성공적으로 크롭
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        self.vc?.navigationController?.popViewController(animated: true)
        didFinishCropping?(cropped)
    }
    
    /// 이미지 크롭 실패
    func cropViewControllerDidFailToCrop(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        let alertController = UIAlertController(title: "크롭 실패", message: "이미지 크롭을 실패했습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.vc?.present(alertController, animated: true, completion: nil)
    }
    
    /// 이미지 크롭 취소
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        let alertController = UIAlertController(title: "크롭 취소", message: "크롭 작업이 취소되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.vc?.present(alertController, animated: true, completion: nil)
    }
    
    /// 이미지 크롭 시작할 경우
    func cropViewControllerDidBeginResize(_ cropViewController: Mantis.CropViewController) {
        print("크롭 크기 조절 작업 시작")
    }
    
    /// 이미지 크롭 완료
    func cropViewControllerDidEndResize(_ cropViewController: Mantis.CropViewController, original: UIImage, cropInfo: Mantis.CropInfo) {
        print("크롭 크기 조절 작업 완료")
    }
}
