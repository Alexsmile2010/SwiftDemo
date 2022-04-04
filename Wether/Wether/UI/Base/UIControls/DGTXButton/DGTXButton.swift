//
//  DGTXButton.swift
//  DGTX
//
//  Created by Alexey Zayakin on 22.03.2021.
//

import UIKit

protocol DGTXButtonConfigurator: ViewConfigurator {
    var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment { get set }
    var contentVerticalAlignment: UIControl.ContentVerticalAlignment { get set }
    var semanticContentAttribute: UISemanticContentAttribute { get set }
    var imageEdgeInsets: UIEdgeInsets { get set }
    var titleEdgeInsets: UIEdgeInsets { get set }
    var contentEdgeInsets: UIEdgeInsets { get set }
    var isHidden: Bool { get set }
    var isEnabled: Bool { get set }
    
    func setLocalizedKey(_ key: LOCKey)
    func setTextColor(_ textColor: AppStyle.Colors)
    func setTextColor(_ textColor: AppStyle.Colors, for state: UIControl.State)
    func setTextFont(_ textFont: AppStyle.Font)
    func setTintColor(_ tintColor: AppStyle.Colors)
    func setImage(_ image: DGTXImagePresetImages, renderMode: UIImage.RenderingMode?)
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
    func setScaleFactor(_ scale: CGFloat)
}

extension DGTXButtonConfigurator where Self: UIButton {
    
    func setLocalizedKey(_ key: LOCKey) {
        setTitle(LOCService.localize(with: key), for: .normal)
    }
    
    func setTextColor(_ textColor: AppStyle.Colors, for state: UIControl.State) {
        setTitleColor(textColor.color, for: state)
    }
    
    func setTextColor(_ textColor: AppStyle.Colors) {
        setTitleColor(textColor.color, for: .normal)
    }
    
    func setTextFont(_ textFont: AppStyle.Font) {
        titleLabel?.font = textFont.font
    }
    
    func setTintColor(_ tintColor: AppStyle.Colors) {
        self.tintColor = tintColor.color
    }
    
    func setImage(_ image: DGTXImagePresetImages, renderMode: UIImage.RenderingMode?) {
        setImage(image.image?.withRenderingMode(renderMode ?? .alwaysTemplate), for: .normal)
    }
    
    func setScaleFactor(_ scale: CGFloat) {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = scale
    }
}

class DGTXButton: UIButton {
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Special init method for simplify localiztion process. All localized keys stored in special  enum: "LOCKey"
    /// - Parameter key: enum of LocalizedKeys
    init(LOCKey key: LOCKey) {
        super.init(frame: .zero)
        setLOCKey(key)
    }
    
    init(presetImage preset: DGTXImagePresetImages, renderMode: UIImage.RenderingMode = .alwaysTemplate) {
        super.init(frame: .zero)
        setPresetImage(preset, renderMode: renderMode)
    }
    
    init(presetImage preset: DGTXImagePresetImages, LOCKey key: LOCKey, renderMode: UIImage.RenderingMode = .alwaysTemplate) {
        super.init(frame: .zero)
        setPresetImage(preset, renderMode: renderMode)
        setLOCKey(key)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPresetImage(_ pressetImage: DGTXImagePresetImages, renderMode: UIImage.RenderingMode = .alwaysTemplate, newWidth: AppLayout? = nil) {
        if let newWidth = newWidth {
            setImage(pressetImage.image?.resizeImage(newWidth: newWidth.value)?.withRenderingMode(renderMode), for: .normal)
        } else {
            setImage(pressetImage.image?.withRenderingMode(renderMode), for: .normal)
        }
    }
    
    func setLOCKey(_ key: LOCKey) {
        setTitle(LOCService.localize(with: key), for: .normal)
    }
}

extension DGTXButton {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension DGTXButton: DGTXButtonConfigurator {
    
    convenience init(_ configurator: (_ button: DGTXButtonConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
