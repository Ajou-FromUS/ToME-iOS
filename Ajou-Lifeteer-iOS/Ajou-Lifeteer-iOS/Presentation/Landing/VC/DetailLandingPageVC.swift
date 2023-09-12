//
//  DetailLandingPageVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/27.
//

import UIKit

import SnapKit
import Then

final class DetailLandingPageVC: UIViewController {
    
    // MARK: - Properties
    
    var isLastPage: Bool = false
        
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .backButton).then {
        $0.layer.applyShadow(alpha: 0.05, x: 0, y: 20, blur: 24)
    }
    
    private lazy var pageDataViewControllers: [UIViewController] = {
        return [FirstDetailLandingPageVC(), SecondDetailLandingPageVC(), ThirdDetailLandingPageVC(), LastDetailLandingPageVC()]
    }()
    
    private let detailLandingPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private var pageControl = UIPageControl()
    
    private let startMindSetButton = CustomButton(title: "마음짓기 시작하기", type: .fillWithBlue)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removePageViewControllerBackground()
        setUI()
        setLayout()
        setFirstDetailLandingPageVC()
        setDelegate()
        setPageControl()
    }
}

// MARK: - Methods

extension DetailLandingPageVC {
    private func setFirstDetailLandingPageVC() {
        if let firstVC = pageDataViewControllers.first {
            detailLandingPageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setDelegate() {
        detailLandingPageViewController.delegate = self
        detailLandingPageViewController.dataSource = self
    }
    
    private func setPageControl() {
        pageControl = UIPageControl.appearance()
        pageControl.numberOfPages = pageDataViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .disabled1
        pageControl.currentPageIndicatorTintColor = .mainColor
        pageControl.backgroundColor = .clear
        pageControl.backgroundStyle = .minimal
        
        // 현재 페이지 인디케이터(currentPageIndicator)의 너비 조정
        let indicatorWidth: CGFloat = 8 // 원하는 너비 값으로 조정
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: indicatorWidth / $0.frame.size.width, y: 1)
            $0.clipsToBounds = false
        }
    }
    
    private func removePageViewControllerBackground() {
        
        /// 첫번째 UIScrollView를 찾아 그 배경을 제거
        if let scrollView = detailLandingPageViewController.view.subviews.compactMap({ $0 as? UIScrollView }).first {
            scrollView.backgroundColor = .white
        }
    }
}

// MARK: - UI & Layout

extension DetailLandingPageVC {
    private func setUI() {
        self.view.backgroundColor = .white
        self.detailLandingPageViewController.view.backgroundColor = .clear
    }
    
    private func setLayout() {
        view.addSubview(naviBar)
        addChild(detailLandingPageViewController)
        view.addSubviews(detailLandingPageViewController.view)
        
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        detailLandingPageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(66)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        detailLandingPageViewController.didMove(toParent: self)
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension DetailLandingPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    /// 왼쪽에서 오른쪽으로 스와이프하기 직전에 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageDataViewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return pageDataViewControllers[previousIndex]
    }
    
    /// 오른쪽에서 왼쪽으로 스와이프하기 직전에 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageDataViewControllers.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        if nextIndex == pageDataViewControllers.count {
            return nil
        }
        return pageDataViewControllers[nextIndex]
    }
    
    /// 인디케이터 초기 값
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    /// 인디케이터를 표시할 페이지의 개수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageDataViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentViewController = pageViewController.viewControllers?.first,
        let currentIndex = pageDataViewControllers.firstIndex(of: currentViewController) else { return }

        if currentIndex == pageDataViewControllers.count - 1 {
            /// 현재 페이지 인덱스가 마지막 페이지 인덱스인 경우
            startMindSetButton.isHidden = false
            view.addSubview(startMindSetButton)
            startMindSetButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.height.equalTo(48)
            }
        } else {
            startMindSetButton.isHidden = true
        }
    }
}
