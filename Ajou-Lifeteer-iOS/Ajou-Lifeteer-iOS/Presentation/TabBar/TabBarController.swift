//
//  TabBarController.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let titleSpacing: UIOffset = UIOffset(horizontal: 0, vertical: -3)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBarControllers()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 92
    }
}

// MARK: - Methods

extension TabBarController {
    
    private func setUI() {
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.tabbar,
            NSAttributedString.Key.foregroundColor: UIColor.font1
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        tabBar.backgroundColor = .font4
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.unselectedItemTintColor = .disabled1
    }
    
    private func setTabBarControllers() {
        let homeMainNVC = templateNavigationController(title: "홈",
                                                          unselectedImage: ImageLiterals.homeIcHome.withRenderingMode(.alwaysOriginal),
                                                          selectedImage: ImageLiterals.homeIcHomeFill.withRenderingMode(.alwaysOriginal),
                                                          rootViewController: HomeMainVC())
        let archiveMainNVC = templateNavigationController(title: "아카이브",
                                                        unselectedImage: ImageLiterals.homeIcArchive.withRenderingMode(.alwaysOriginal),
                                                        selectedImage: ImageLiterals.homeIcArchiveFill.withRenderingMode(.alwaysOriginal),
                                                        rootViewController: ArchiveMainVC())
        let diaryMainNVC = templateNavigationController(title: "일기",
                                                               unselectedImage: ImageLiterals.homeIcDiary.withRenderingMode(.alwaysOriginal),
                                                               selectedImage: ImageLiterals.homeIcDiaryFill.withRenderingMode(.alwaysOriginal),
                                                               rootViewController: DiaryMainVC())
        let talkingMainNVC = templateNavigationController(title: "ToME",
                                                         unselectedImage: ImageLiterals.homeIcConversation.withRenderingMode(.alwaysOriginal),
                                                         selectedImage: ImageLiterals.homeIcConversationFill.withRenderingMode(.alwaysOriginal),
                                                             rootViewController: TalkingMainVC())
        
        /// 탭바 아이템과 타이틀 간의 간격 조정
        for tabBarInfo in [homeMainNVC, archiveMainNVC, diaryMainNVC, talkingMainNVC] {
            tabBarInfo.tabBarItem.titlePositionAdjustment = titleSpacing
        }
        
        viewControllers = [homeMainNVC, archiveMainNVC, diaryMainNVC, talkingMainNVC]
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
