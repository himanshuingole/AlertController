//
//  UIView.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/14/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedView: UIView {

    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            applyCorner()
        }
    }
    
    @IBInspectable var topLeft: Bool = false {
        didSet {
            applyCorner()
        }
    }
    
    @IBInspectable var topRight: Bool = false {
        didSet {
            applyCorner()
        }
    }
    
    
    @IBInspectable var bottomLeft: Bool = false {
        didSet {
            applyCorner()
        }
    }
    
    @IBInspectable var bottomRight: Bool = false {
        didSet {
            applyCorner()
        }
    }
    
    @IBInspectable var allCorner: Bool = true {
        didSet {
            applyCorner()
        }
    }
    
    func getCornerToApply() -> UIRectCorner {
        if allCorner {
            return .allCorners
        } else {
            var corner = UIRectCorner(rawValue: 0)
            topLeft ? corner = corner.union(.topLeft) : nil
            topRight ? corner = corner.union(.topRight) : nil
            bottomLeft ? corner = corner.union(.bottomLeft) : nil
            bottomRight ? corner = corner.union(.bottomRight) : nil
            return corner
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCorner()
    }
    
    private func applyCorner() {
        
        let path = UIBezierPath.init(roundedRect: bounds,
                                     byRoundingCorners: getCornerToApply(),
                                     cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
