//
//  UIButtonX.swift
//  ToDoApp
//
//  Created by Mohsin Hassan on 05/07/2025.
//

import UIKit

@IBDesignable
class UIButtonX: UIButton {

    @IBInspectable var isRounded: Bool = false

    enum FromDirection: Int {
        case top = 0
        case right = 1
        case bottom = 2
        case left = 3
    }

    var shadowView: UIView!
    var direction: FromDirection = .left
    var alphaBefore: CGFloat = 1

    @IBInspectable var animate: Bool = false
    @IBInspectable var animateDelay: Double = 0.2
    @IBInspectable var animateFrom: Int {
        get {
            return direction.rawValue
        }
        set (directionIndex) {
            direction = FromDirection(rawValue: directionIndex) ?? .left
        }
    }

    @IBInspectable var popIn: Bool = false
    @IBInspectable var popInDelay: Double = 0.4

    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true

        if animate {
            let originalFrame = frame

            if direction == .bottom {
                frame = CGRect(x: frame.origin.x,
                               y: frame.origin.y + 200,
                               width: frame.width,
                               height: frame.height)
            }

            UIView.animate(withDuration: 0.3,
                           delay: animateDelay,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
//                           options: .allowUserInteraction,
                           animations: {
                self.frame = originalFrame
            }, completion: nil)
        }

        if popIn {
            transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.8,
                           delay: popInDelay,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
//                           options: .allowUserInteraction,
                           animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }

        if shadowView == nil && shadowOpacity > 0 {
            shadowView = UIView(frame: self.frame)
            shadowView.backgroundColor = UIColor.clear
            shadowView.layer.shadowColor = shadowColor.cgColor
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                                       cornerRadius: self.cornerRadius).cgPath
            shadowView.layer.shadowOffset = shadowOffset
            shadowView.layer.shadowOpacity = Float(shadowOpacity)
            shadowView.layer.shadowRadius = shadowRadius
            shadowView.layer.masksToBounds = true
            shadowView.clipsToBounds = false

            self.superview?.addSubview(shadowView)
            self.superview?.bringSubviewToFront(self)
        }

        if isRounded {
            self.clipsToBounds = true
            self.cornerRadius = self.frame.size.height / 2
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        alphaBefore = alpha

        UIView.animate(withDuration: 0.2, delay: 0,
//                       options: .allowUserInteraction,
                       animations: {
//                        self.alpha = 0.4
                       })

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.35, delay: 0,
//                       options: .allowUserInteraction,
                       animations: {
                        self.alpha = self.alphaBefore
                       })
    }

    // MARK: - Borders

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    // MARK: - Shadow

    @IBInspectable public var shadowOpacity: CGFloat = 0
    @IBInspectable public var shadowColor: UIColor = UIColor.clear
    @IBInspectable public var shadowRadius: CGFloat = 0
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0)

   // MARK: - Gradient
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }

    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    func updateView() {
        // swiftlint:disable force_cast
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]

        if horizontalGradient {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
    }
    
    func setBorders(borderColor: UIColor? = nil, borderWidth: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        self.borderWidth = borderWidth ?? 0
        self.borderColor = borderColor ?? .clear
        self.cornerRadius = cornerRadius ?? 0
    }
    
    func setGradientColor(first: UIColor, second: UIColor, horizontalGradient: Bool) {
        firstColor = first
        secondColor = second
        self.horizontalGradient = horizontalGradient
    }
}
