//
//  AlertAction.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/21/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import Foundation
import UIKit

/// protocol for alert action button properties
protocol AlertActionType {
    
    /// buttonTitle
    var title: String { get }
    
    /// action when alert button tapped
    var tapAction: (() -> Void)? { get }
    var height: CGFloat { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}


/// Alert Action adopt alert action type
struct AlertAction: AlertActionType {
    var title: String
    var tapAction: (() -> Void)?
    var height: CGFloat
    var backgroundColor: UIColor
    var textColor: UIColor
    
    init(title: String = "Ok",
         tapAction: (() -> Void)? = nil,
         height: CGFloat = 50.0,
         backgroundColor: UIColor = UIColor.init(red: (246/255), green: (246/255), blue: (246/255), alpha: 1),
         textColor: UIColor = .black) {
        self.title = title
        self.tapAction = tapAction
        self.height = height
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
