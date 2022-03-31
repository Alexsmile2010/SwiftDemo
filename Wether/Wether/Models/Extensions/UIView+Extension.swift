//
//  UIViewExt.swift
//  Blockster
//
//  Created by Edward Gray on 26.02.2021.
//

import UIKit
import SnapKit

extension UIView {
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
    
    func applyBorderStyle(_ style: BorderStyle) {
        layer.borderColor = style.borderColor
        layer.borderWidth = style.borderWidth
    }
    
    func applyColorStyle(_ style: ColorStyle) {
        backgroundColor = style.backgroundColor
    }
    
    func applyCornerRadiusStyle(_ style: CornerRadiusStyle) {
        layer.cornerRadius = style.cornerRadius
    }
    
    func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    func addTap(tapNumber: Int = 1, _ completion: @escaping () -> ()) {
        self.addTapGesture(tapNumber: tapNumber, action: { (_) in
            completion()
        })
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func addImage(preset: DGTXImageViewPresetImages, width: CGFloat, xScale: CGFloat, yScale: CGFloat) {
        let imageView = DGTXImageView(withPresetImage: preset, renderMode: .alwaysOriginal)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.centerX.equalToSuperview().multipliedBy(xScale)
            make.centerY.equalToSuperview().multipliedBy(yScale)
        }
    }

}

// MARK: - SnapKit Constraints

extension UIView {
    var bottomSafeAreaConstraint: ConstraintItem {
        return safeAreaLayoutGuide.snp.bottom
    }
    var topSafeAreaConstraint: ConstraintItem {
        return safeAreaLayoutGuide.snp.top
    }
}

// MARK: - BlockTap

///Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
final class BlockTap: UITapGestureRecognizer {
    
    private var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    convenience init(
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?
    ) {
        self.init()
        numberOfTapsRequired = tapCount
        
        #if os(iOS)
        numberOfTouchesRequired = fingerCount
        #endif
        
        tapAction = action
        addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }
    
    @objc func didTap(_ tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }
}


