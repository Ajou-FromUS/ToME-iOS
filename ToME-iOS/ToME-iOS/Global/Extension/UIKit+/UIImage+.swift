//
//  UIImage+.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UIImage {
    /// 이미지의 용량을 줄이기 위해서 리사이즈.
    /// - 가로, 세로 중 짧은 것이 720 보다 작다면 그대로 반환.
    /// - 가로, 세로 중 짧은 것이 720 보다 크다면 720 으로 리사이즈해서 반환.
    func resize() -> UIImage {
        let width = self.size.width
        let height = self.size.height
        let resizeLength: CGFloat = 720.0
        
        var scale: CGFloat
        
        if height >= width {
            scale = width <= resizeLength ? 1 : resizeLength / width
        } else {
            scale = height <= resizeLength ? 1 :resizeLength / height
        }
        
        let newHeight = height * scale
        let newWidth = width * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    /// UIView를 image로 변환
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
