//
//  GlobalProtocols.swift
//  DGTX
//
//  Created by Alexey Zayakin on 24.03.2021.
//

import Foundation
import UIKit

protocol BaseViewModel {}

protocol ViewConfigurator: AnyObject {
    var translatesAutoresizingMaskIntoConstraints: Bool { get set }
    var clipsToBounds: Bool { get set }
    var isHidden: Bool { get set }
    
    func setBackgroundColor(_ bgColor: AppStyle.Colors)
    func setCornerRadius(_ cornerRadius: AppLayoutCornerRadius)
    func setBorderWidth(_ borderWidth: AppStyle.BorderWidth)
    func setBorderColor(_ borderColor: AppStyle.Colors)
    func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis)
    func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis)
}

extension ViewConfigurator where Self: UIView {
    func setBackgroundColor(_ bgColor: AppStyle.Colors) {
        backgroundColor = bgColor.color
    }
    
    func setCornerRadius(_ cornerRadius: AppLayoutCornerRadius) {
        layer.cornerRadius = cornerRadius.rawValue
        layer.masksToBounds = true
    }
    
    func setBorderWidth(_ borderWidth: AppStyle.BorderWidth) {
        layer.borderWidth = borderWidth.value
    }
    
    func setBorderColor(_ borderColor: AppStyle.Colors) {
        layer.borderColor = borderColor.color.cgColor
    }
}

protocol ViewInitializtion {
    func setUpConstraints()
    func setUpViewModel()
    func setUpView()
}

protocol CornerRadiusStyle {
    var cornerRadius: CGFloat { get }
}

//MARK: - Font
//Describe font style
protocol FontStyle {
    var font: UIFont { get }
    var fontColor: UIColor { get }
    var numberOfLines: Int { get }
}

//MARK: - BackgroundColor
//Describe background color
protocol ColorStyle {
    var backgroundColor: UIColor { get }
}

//Default value
extension ColorStyle {
    var backgroundColor: UIColor {
        return .clear
    }
}

//MARK: - Border
//Describe border properties
protocol BorderStyle {
    var borderWidth: CGFloat { get }
    var borderColor: CGColor { get }
}


