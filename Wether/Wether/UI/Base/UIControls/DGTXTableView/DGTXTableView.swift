//
//  DGTXTableView.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 24.06.2021.
//

import UIKit

class DGTXTableView: UITableView {
    
    init(with style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = AppStyle.Colors.background(.primary).color
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        tableFooterView = UIView()
        
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0.0
        }
    }
}

extension DGTXTableView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}
