//
//  DGTXTextField.swift
//  DGTX
//
//  Created by Alexey Zayakin on 23.03.2021.
//

import UIKit

class DGTXTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
    }
    
    private func setUpUI() {
        tintColor = AppStyle.Colors.background(.primary).color
    }
}

extension DGTXTextField {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

//MARK: - Localization Init

extension DGTXTextField {
    
    /// Special init method for simplify localiztion process. All localized keys stored in special  enum: "LOCKey"
    /// - Parameter key: enum of LocalizedKeys
    convenience init(withLOCKey key: LOCKey) {
        self.init(frame: .zero)
        placeholder = LOCService.localize(with: key)
    }
}
