//
//  MindSetHomeVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class MindSetHomeVC: UIViewController {
        
    let testAlertVC = CustomAlertVC(title: "첫 번째 음성유언을 삭제할까요?", type: .yesOrNoAlert).then {
        $0.setDescriptionLabel(description: "삭제된 음성유언의 데이터는 영구적으로 사라집니다.")
        $0.setButtonTitle(fillWithGreenButtonTitle: "아니오", borderWithoutBGCButtonTitle: "네")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = false
        testAlertVC.modalPresentationStyle = .overFullScreen
        self.present(testAlertVC, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
}
