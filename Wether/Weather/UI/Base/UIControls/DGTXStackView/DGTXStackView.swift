//
//  DGTXStackView.swift
//  DGTX
//
//  Created by Alexey Zayakin on 13.05.2021.
//

import UIKit

protocol DGTXStackViewConfigurator: ViewConfigurator {
    var axis: NSLayoutConstraint.Axis { get set }
    var distribution: UIStackView.Distribution { get set }
    var alignment: UIStackView.Alignment { get set }
    var directionalLayoutMargins: NSDirectionalEdgeInsets { get set }
    var isLayoutMarginsRelativeArrangement: Bool { get set }
    
    func setSpacing(_ space: AppLayout)
    func setDirectionMargin(_ margin: AppLayout)
}

extension DGTXStackViewConfigurator where Self: UIStackView {
    
    func setSpacing(_ space: AppLayout) {
        spacing = space.value
    }
    
    func setDirectionMargin(_ margin: AppLayout) {
        isLayoutMarginsRelativeArrangement = true
        let value = margin.value
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
}

class DGTXStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DGTXStackView: DGTXStackViewConfigurator {
    convenience init(_ configurator: (_ stack: DGTXStackViewConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
