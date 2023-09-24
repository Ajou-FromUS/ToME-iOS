//
//  UINavigationController+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/15.
//

import UIKit

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
