//
//  AlertViewModel.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/20/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import Foundation
import UIKit
protocol AlertViewModelType {
    var title: String { get }
    var message: String { get }
    var alertStyle: AlertStyle { get }
    var numberOfButtonInRow: CGFloat { get }
    var actions: [AlertActionType] { get }
    var height: CGFloat { get }
    var spacing: CGFloat { get }
}

struct AlertViewModel: AlertViewModelType {
    
    var title: String
    var message: String
    var alertStyle: AlertStyle
    var numberOfButtonInRow: CGFloat
    var actions: [AlertActionType]
    var height: CGFloat
    var spacing: CGFloat

    
    init (title: String,
          message: String,
          alertStyle: AlertStyle  = .basic,
          numberOfButtonInRow: CGFloat = 1,
          actions: [AlertActionType] = [AlertAction()],
          height: CGFloat = alertDefaultHeight,
          spacing: CGFloat = alertDefaultActionItemSpace) {
        self.title = title
        self.message = message
        self.alertStyle = alertStyle
        self.numberOfButtonInRow = numberOfButtonInRow
        self.actions = actions
        self.height = height
        self.spacing = spacing
    }
}
