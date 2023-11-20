//
//  setTextLineHeight.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

extension UILabel {
    public func setTextWithLineHeight(text: String?, lineHeightMultiple: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.lineHeightMultiple = lineHeightMultiple
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}

extension UITextView {
    public func setTextWithLineHeight(text: String?, lineHeightMultiple: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.lineHeightMultiple = lineHeightMultiple
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
