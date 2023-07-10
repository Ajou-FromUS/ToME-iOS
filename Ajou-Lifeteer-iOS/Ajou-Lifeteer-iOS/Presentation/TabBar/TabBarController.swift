//
//  TabBarController.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var upperLineView: UIView!
    private let spacing: CGFloat = 15
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setTabBarControllers()
        setUpperLine()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 92
        tabBar.frame.origin.y = view.frame.height - 92
    }
}

// MARK: - Methods

extension TabBarController {
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setUI() {
        tabBar.backgroundColor = .mainBackground
        tabBar.unselectedItemTintColor = .disabledText
        tabBar.tintColor = .mainGreen
    }
    
    private func setTabBarControllers() {
        let mindSetHomeNVC = templateNavigationController(title: "마음짓기",
                                                          unselectedImage: ImageLiterals.icMindset,
                                                          selectedImage: ImageLiterals.icMindsetFill,
                                                          rootViewController: MindSetHomeVC())
        let diaryMainNVC = templateNavigationController(title: "일기",
                                                        unselectedImage: ImageLiterals.icDiary,
                                                        selectedImage: ImageLiterals.icDiaryFill,
                                                        rootViewController: DiaryMainVC())
        let recordedWillMainNVC = templateNavigationController(title: "음성유언",
                                                               unselectedImage: ImageLiterals.icRecordedWill,
                                                               selectedImage: ImageLiterals.icRecordedWillFill,
                                                               rootViewController: RecordedWillMainVC())
        let mypageMainNVC = templateNavigationController(title: "마이페이지",
                                                             unselectedImage: ImageLiterals.icMypage,
                                                             selectedImage: ImageLiterals.icMypageFill,
                                                             rootViewController: MypageMainVC())

        viewControllers = [mindSetHomeNVC, diaryMainNVC, recordedWillMainNVC, mypageMainNVC]
    }
    
    private func setUpperLine() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabBarIndicatorView(index: 0, isFirstTime: true)
        }
    }
    
    /// Add tabbar item indicator upper line
    private func addTabBarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return }
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 2))
        upperLineView.backgroundColor = .mainGreen
        tabBar.addSubview(upperLineView)
    }
    
    private func templateNavigationController(title: String, unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.isHidden = true
        return nav
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabBarIndicatorView(index: self.selectedIndex)
    }
}
