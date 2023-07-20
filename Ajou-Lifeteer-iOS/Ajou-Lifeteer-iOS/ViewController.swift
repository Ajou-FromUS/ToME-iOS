//
//  ViewController.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    private let image =  UIImageView().then {
        $0.image = ImageLiterals.icAddPhoto
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(image)
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
