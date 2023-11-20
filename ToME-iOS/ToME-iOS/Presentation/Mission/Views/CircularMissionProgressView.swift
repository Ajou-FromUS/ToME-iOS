//
//  CircularMissionProgressView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/8/23.
//

import UIKit

class CircularMissionProgressView: UIView {

    // MARK: - Properties
    
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - View Life Cycle
        
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect)
        
        // 진행 부분 그리기
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.8
        let startAngle = -CGFloat.pi / 2 // 12시 방향부터 시작
        var endAngle = startAngle - progress * 2 * CGFloat.pi // 시계 반대방향으로 진행하도록 음수 각도를 사용
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        progressPath.lineWidth = 17
        UIColor.mainColor.setStroke()
        progressPath.stroke()
        
        if startAngle == endAngle {
            endAngle = 360 // start와 end가 같을 경우, 두 사이의 각도가 0으로 설정되어 화면에 표시되지 않음
        }
        
        // 남은 부분 그리기
        let remainingPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: endAngle, endAngle: startAngle + 2 * CGFloat.pi, clockwise: false)
        remainingPath.lineWidth = 17
        UIColor.sub2.setStroke() // 남은 부분의 선 색상을 원하는 색으로 변경
        remainingPath.stroke()
    }
}
