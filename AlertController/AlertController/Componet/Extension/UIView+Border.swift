//
//  UIView+Border.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/21/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return self.layer.borderColor.flatMap(UIColor.init) ?? nil
        }
        
        set {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}
