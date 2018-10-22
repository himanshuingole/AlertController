//
//  AlertController.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/14/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import UIKit

/// Class to provide customize alert controller. It works on MVVM approach. where as passed view model
/// handles controllers various properties like, title, background color number of buttons spacing etc. Please
/// AlertViewModel for more details.
@IBDesignable
class AlertController: UIViewController {
    
    
    /// height constriant for title
    @IBOutlet weak var alertTitleHeightConstraint: NSLayoutConstraint!
    
    /// alert title label
    @IBOutlet private weak var alertTitleLabel: UILabel!
    
    /// alert text view - text view help detecting phone number, currencey etc therefore its better to render message in textview
    @IBOutlet private weak var alertTextView: UITextView!
    
    /// stack view to hold dynamically added buttons - Alert controller suppport multiple buttons
    @IBOutlet private weak var buttonsStackView: UIStackView!
    
    /// text view height constraint
    @IBOutlet private weak var textViewHeightConstraint: NSLayoutConstraint!
    
    /// top,bottom, left and right constraint - view model support customization of spacing also
    @IBOutlet private weak var containerTopSpacingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerRightSpacingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerLeftSpacingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerBottomSpacingConstraint: NSLayoutConstraint!
    
    /// backbone of alert controller - provide all configuration to the alert controller
    private var viewModel: AlertViewModelType
    
    /// container view - contains all control. referenec to container view applied for animation
    @IBOutlet private weak var containerView: RoundedView!
    
    /// button container view - required as stack view doesnt have its background color
    @IBOutlet private weak var buttonsContainerView: UIView!
    
    /// override model presentation in order to support blur view
    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .overCurrentContext
        }
        set {
            
        }
    }
    
    /// configure method - this method calls submethods to configure respective controls.
    private func configure() {
        configureContainerView()
        configureTitleLabel()
        configureActionItems()
        configureMessageView()
    }
    
    /// method for container view configuration - view model provide container view configuration
    private func configureContainerView() {
        containerView.backgroundColor = viewModel.alertStyle.backgroundColor
        buttonsContainerView.backgroundColor = viewModel.alertStyle.backgroundColor
        containerTopSpacingConstraint.constant = viewModel.alertStyle.topSpace
        containerLeftSpacingConstraint.constant = viewModel.alertStyle.leftSpace
        containerRightSpacingConstraint.constant = viewModel.alertStyle.rightSpace
        containerBottomSpacingConstraint.constant = viewModel.alertStyle.bottomSpace
    }
    
    /// method for container title Label - view model provide title label configuration
    private func configureTitleLabel() {
        alertTitleLabel.text = viewModel.title
        alertTitleLabel.backgroundColor = viewModel.alertStyle.titleBackground
        alertTitleLabel.font = viewModel.alertStyle.titleFont
        alertTitleLabel.textColor = viewModel.alertStyle.titeTextColor
        alertTitleLabel.textAlignment = viewModel.alertStyle.titleTextAlignment
        alertTitleHeightConstraint.constant = viewModel.alertStyle.titleHeight
    }
    
    /// method for message view configuration - view model provide message view configuration
    /// height calculation based on content title label and button
    private func configureMessageView() {
        alertTextView.text = viewModel.message
        alertTextView.backgroundColor = viewModel.alertStyle.messageBackgroundColor
        alertTextView.font = viewModel.alertStyle.messageFont
        alertTextView.textColor = viewModel.alertStyle.messageTextColor
        alertTextView.contentInset = viewModel.alertStyle.messageContentInset
        let availableWidth  = UIScreen.main.bounds.width - ( viewModel.alertStyle.leftSpace + viewModel.alertStyle.rightSpace + alertTextView.contentInset.left + alertTextView.contentInset.right + 50)
        let textHeight = viewModel.message.heightWithConstrainedWidth(width: availableWidth,
                                                                      font: viewModel.alertStyle.messageFont)
        let buttonsHeight = buttonsStackView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height  + viewModel.alertStyle.topSpace + viewModel.alertStyle.bottomSpace
        let maxHeight = UIScreen.main.bounds.height
        let alertHeight = viewModel.alertStyle.titleHeight + textHeight + buttonsHeight
        if alertHeight < viewModel.height {
            textViewHeightConstraint.constant = textHeight + (viewModel.height  - alertHeight)
        } else if alertHeight > maxHeight {
            textViewHeightConstraint.constant = textHeight - ( (alertHeight - maxHeight) + viewModel.alertStyle.titleHeight + buttonsHeight)
        } else {
            textViewHeightConstraint.constant = textHeight
        }
    }
    
    /// method for action button configuration - view model provie action buttons configuration
    private func configureActionItems() {
        buttonsStackView.removeAllArrangedSubviews()
        buttonsStackView.spacing = viewModel.spacing
        var currnetButtonIndex = 0
        var childButtonContainer: UIStackView?
        viewModel.actions.enumerated().forEach {
            let button = UIButton(type: .custom)
            button.setTitle($1.title, for: .normal)
            button.tag = $0
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: $1.height).isActive = true
            button.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
            button.setTitleColor($1.textColor, for: .normal)
            button.backgroundColor = $1.backgroundColor
            if viewModel.numberOfButtonInRow > 1 {
                if currnetButtonIndex == 0 {
                    childButtonContainer = UIStackView()
                    childButtonContainer?.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
                    childButtonContainer?.axis = .horizontal
                    childButtonContainer?.alignment = .fill
                    childButtonContainer?.distribution = .fillEqually
                    childButtonContainer?.spacing = viewModel.spacing
                    childButtonContainer?.backgroundColor = UIColor.white
                }
                childButtonContainer?.addArrangedSubview(button)
                currnetButtonIndex = currnetButtonIndex + 1
                if currnetButtonIndex == Int(viewModel.numberOfButtonInRow) {
                    currnetButtonIndex = 0
                    buttonsStackView.addArrangedSubview(childButtonContainer ?? UIView())
                } else if $0 + 1 == viewModel.actions.count {
                    buttonsStackView.addArrangedSubview(childButtonContainer ?? UIView())
                }
            } else {
                buttonsStackView.addArrangedSubview(button)
            }
        }
    }
    
    /// All action button created by controller gets called by button tapped.
    /// Based on setted tag it further determines which button was tapped if viewmodel has tap event then it will also be excuted by this method and last it call dismiss method which perform animation
    /// - Parameter button: tapped button passed to this
    @objc func buttonTapped(button: UIButton) {
        viewModel.actions[button.tag].tapAction?()
        dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        applyAnimaton()
    }

    
    /// Init method for Alert controller
    ///
    /// - Parameter viewModel: view model act as backbone for alert controller. View model not only the content but also its color, space size any many other proeprties
    public init (viewModel: AlertViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "AlertController", bundle: nil)
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// animation method - this methods gets called by viewWillAppear and viewWillDisappear
    /// it offers scale animation - which is applied on container view
    /// - Parameters:
    ///   - isAlertAppearing: bool to determin weather alert is appearing to disappearing
    ///   - completion: completion handler to perform tasks after animation finish
    private func applyAnimaton(isAlertAppearing: Bool = true,
                       completion: (() -> Void)? = nil) {
        let animateOut = { [unowned self] in
            self.containerView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            self.containerView.alpha = 0
        }
        let animateIn = { [unowned self] in
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 1
        }
        isAlertAppearing ? animateOut() : animateIn()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.9,
                       options: isAlertAppearing ? .curveEaseIn : .curveEaseOut,
                       animations: {
                        isAlertAppearing ? animateIn() : animateOut()
        },
                       completion: {_ in completion?()})
    }

    
    /// tap gesture associated method - which gets call when view is touched
    ///
    /// - Parameter sender:
    @IBAction private func viewTapped(_ sender: Any) {
        dismiss()
    }
    
    
    /// dismiss the alert controller after performing the animation
    private func dismiss() {
        applyAnimaton(isAlertAppearing: false) { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
