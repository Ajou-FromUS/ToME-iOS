// MIT License
//
// Copyright (c) 2017-2019 MessageKit
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

open class TypingBubble: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubviews()
  }

  open var isPulseEnabled = true

  open override var backgroundColor: UIColor? {
    set {
      contentBubble.backgroundColor = newValue
    }
    get {
      contentBubble.backgroundColor
    }
  }

  open var contentPulseAnimationLayer: CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.fromValue = 1
    animation.toValue = 1.04
    animation.duration = 1
    animation.repeatCount = .infinity
    animation.autoreverses = true
    return animation
  }

  open func setupSubviews() {
    addSubview(contentBubble)
    contentBubble.addSubview(typingIndicator)
      backgroundColor = .red
  }

  open override func layoutSubviews() {
    super.layoutSubviews()

    guard bounds.width > 0, bounds.height > 0 else { return }

    let ratio = bounds.width / bounds.height
    let extraRightInset = bounds.width - 1.65 / ratio * bounds.width

    let tinyBubbleRadius: CGFloat = bounds.height / 6

    let contentBubbleFrame = CGRect(
      x: tinyBubbleRadius,
      y: 0,
      width: bounds.width - tinyBubbleRadius - extraRightInset,
      height: bounds.height)
    let contentBubbleFrameCornerRadius = contentBubbleFrame.height / 2

    contentBubble.frame = contentBubbleFrame
    contentBubble.layer.cornerRadius = contentBubbleFrameCornerRadius

    let insets = UIEdgeInsets(
      top: 0,
      left: contentBubbleFrameCornerRadius / 1.25,
      bottom: 0,
      right: contentBubbleFrameCornerRadius / 1.25)
    typingIndicator.frame = contentBubble.bounds.inset(by: insets)
  }

  open func startAnimating() {
    defer { isAnimating = true }
    guard !isAnimating else { return }
    typingIndicator.startAnimating()
    if isPulseEnabled {
      contentBubble.layer.add(contentPulseAnimationLayer, forKey: AnimationKeys.pulse)
    }
  }

  open func stopAnimating() {
    defer { isAnimating = false }
    guard isAnimating else { return }
    typingIndicator.stopAnimating()
    contentBubble.layer.removeAnimation(forKey: AnimationKeys.pulse)
  }

  public private(set) var isAnimating = false

  public let contentBubble = UIView()

  public let typingIndicator = TypingIndicator()

  private enum AnimationKeys {
    static let pulse = "typingBubble.pulse"
  }
}
