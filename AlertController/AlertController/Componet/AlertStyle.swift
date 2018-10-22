//
//  AlertViewModel.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/20/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import Foundation
import UIKit

/// default values for alert controller

/// default height of alert controller - irrespective of content, height of alert controller
let alertDefaultHeight: CGFloat = 350.0

/// alert controller button spacing
let alertDefaultActionItemSpace: CGFloat = 5.0

/// alert controller button height
let alertDefaultActionItemHeight: CGFloat = 50.0

protocol AlertStyleType {

    /// background color of alert controller - this applies to the container view
    var backgroundColor: UIColor { get }
    
    /// corner radious of container view
    var cornerRadious: CGFloat { get }
    
    /// top,botton, left and right spacing of container view
    var leftSpace: CGFloat { get }
    var rightSpace: CGFloat { get }
    var topSpace: CGFloat { get }
    var bottomSpace: CGFloat { get }

    /// alert title font
    var titleFont: UIFont { get }
    
    /// title height
    var titleHeight: CGFloat { get }
    
    /// title background
    var titleBackground: UIColor { get }
    
    /// title text color
    var titeTextColor: UIColor { get }
    
    /// title text alignment
    var titleTextAlignment:  NSTextAlignment  { get }

    
    /// message view font
    var messageFont: UIFont { get }
    
    /// message view background
    var messageBackgroundColor: UIColor { get }
    
    /// message text color
    var messageTextColor: UIColor { get }
    
    /// message content inset
    var messageContentInset: UIEdgeInsets { get }

}

/// it offers values for AlertStyleType properties

enum AlertStyle: AlertStyleType {
    
    
    /// offer basic configuration
    case basic
    /// custom configuration
    case custom
    /// background color
    ///
    /// currnetly it support only one type of background however, this can be change
    ///
    ///    switch style {
    ///
    ///    case basic:
    ///
    ///         return basic color
    ///
    ///    case custom
    ///
    ///         return custom color
    ///
    ///    }
    ///
    var backgroundColor: UIColor {
        return .white
    }
    
    var cornerRadious: CGFloat {
        return 10
    }
    
    var leftSpace: CGFloat {
        return 15
    }
    
    var rightSpace: CGFloat {
        return 15
    }
    
    var topSpace: CGFloat {
        return 15
    }
    
    var bottomSpace: CGFloat {
        return 15
    }
   
    var titleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    var titleHeight: CGFloat {
        return 50.0
    }
    
    var titleBackground: UIColor {
        return UIColor(red: (48/255), green: (132/255), blue: (229/255), alpha: 1)
    }
    
    var titeTextColor: UIColor {
        return .white
    }
    
    var titleTextAlignment: NSTextAlignment {
        return .center
    }
    
    var messageFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    var messageBackgroundColor: UIColor {
        return .white
    }
    
    var messageTextColor: UIColor {
        return .black
    }
    
    var messageContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 10,
                            bottom: 0,
                            right: 10)
    }
 
}
