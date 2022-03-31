//
//  DynamicCollectionView.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 11.10.2021.
//

import Foundation
import UIKit

final class DynamicCollectionView: DGTXCollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
