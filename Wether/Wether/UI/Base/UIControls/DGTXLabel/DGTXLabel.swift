//
//  DGTXLabel.swift
//  DGTX
//
//  Created by Alexey Zayakin on 07.04.2021.
//

import UIKit


protocol DGTXLabelConfigurator: ViewConfigurator {
    var numberOfLines: Int { get set }
    var textAlignment: NSTextAlignment { get set }
    var lineBreakMode: NSLineBreakMode { get set }
    var attributedText: NSAttributedString? { get set }
    var isUserInteractionEnabled: Bool { get set }
    
    func setLocalizedKey(_ key: LOCKey)
    func setTextColor(_ textColor: AppStyle.Colors)
    func setTextFont(_ textFont: AppStyle.Font)
    func setCorenerRadius(_ radius: AppLayoutCornerRadius)
    func setTintColor(_ textColor: AppStyle.Colors)
}

extension DGTXLabelConfigurator where Self: UILabel {
    
    func setLocalizedKey(_ key: LOCKey) {
        self.text = LOCService.localize(with: key)
    }
    
    func setTextColor(_ textColor: AppStyle.Colors) {
        self.textColor = textColor.color
    }
    
    func setTextFont(_ textFont: AppStyle.Font) {
        self.font = textFont.font
    }
    
    func setCorenerRadius(_ radius: AppLayoutCornerRadius) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius.rawValue
    }
    
    func setTintColor(_ tintColor: AppStyle.Colors) {
        self.tintColor = tintColor.color
    }
}

class DGTXLabel: UILabel {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DGTXLabel {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension DGTXLabel {
    
    /// Special init method for simplify localiztion process. All localized keys stored in special  enum: "LOCKey"
    /// - Parameter key: enum of LocalizedKeys
    convenience init(withLOCKey key: LOCKey) {
        self.init()
        text = LOCService.localize(with: key)
    }
}

extension DGTXLabel: DGTXLabelConfigurator {
    
    convenience init(_ configurator: (_ label: DGTXLabelConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
