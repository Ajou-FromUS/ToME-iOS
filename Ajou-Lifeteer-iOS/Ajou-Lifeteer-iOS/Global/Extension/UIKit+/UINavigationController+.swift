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
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func fadePop(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 1
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
    }
}
