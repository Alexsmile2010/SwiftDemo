//
//  Array+Extension.swift
//  Blockster
//
//  Created by Alexey Zayakin on 19.08.2021.
//

import Foundation
import UIKit

extension Array where Element: UIView {
    
    func embeddedInStackView(_ configure: (_ stack: DGTXStackViewConfigurator) -> ()) -> DGTXStackView {
        let stackView = DGTXStackView()
        forEach { view in
            stackView.addArrangedSubview(view)
        }
        configure(stackView)
        return stackView
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
