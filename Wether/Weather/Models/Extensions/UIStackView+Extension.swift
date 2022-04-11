//
//  UIStackView+Extension.swift
//  Blockster
//
//  Created by Alexey Zayakin on 08.09.2021.
//

import UIKit

struct EmbededLayoutInset {
    var leading: AppLayoutSideSpacing
    var trailing: AppLayoutSideSpacing
    var top: AppLayoutSideSpacing
    var bottom: AppLayoutSideSpacing
}

extension UIStackView {
    
    @discardableResult
    func storeIn(_ view: UIView) -> UIStackView {
        view.addSubview(self)
        return self
    }
    
    func storeIn(_ stackView: UIStackView, basedOnEmptyView: Bool = false) {
        stackView.addArrangedSubview(self)
    }
    
    func embeddedInView(_ layout: EmbededLayoutInset) -> UIView {
        let view = DGTXView()
        view.addSubview(self)
        snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(layout.leading.rawValue)
            make.trailing.equalToSuperview().inset(layout.trailing.rawValue)
            make.top.equalToSuperview().inset(layout.top.rawValue)
            make.bottom.equalToSuperview().inset(layout.bottom.rawValue)
        }
        return view
    }
}
