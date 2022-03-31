//
//  DGTXView.swift
//  DGTX
//
//  Created by Alexey Zayakin on 22.03.2021.
//

import UIKit

protocol DGTXViewConfigurator: ViewConfigurator {}

class DGTXView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DGTXView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension DGTXView: DGTXViewConfigurator {
    
    convenience init(_ configurator: (_ view: DGTXViewConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
