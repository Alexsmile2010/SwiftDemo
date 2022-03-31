//
//  CellConstructor.swift
//  DGTX
//
//  Created by Alexey Zayakin on 12.04.2021.
//

import Foundation
import UIKit

struct TableCellContainer<T: UITableViewCell> {
    private var constructor: () -> T?
    
    init(_ constructor: @escaping () -> T?) {
        self.constructor = constructor
    }
    
    func configure(_ closure: (_ cell: T) -> ()) -> UITableViewCell {
        switch constructor() {
        case .some(let unwrapped):
            closure(unwrapped)
            return unwrapped
        case .none:
            return UITableViewCell()
        }
    }
}

struct CollectionCellContainer<T: UICollectionViewCell> {
    private var constructor: () -> T?
    
    init(_ constructor: @escaping () -> T?) {
        self.constructor = constructor
    }
    
    func configure(_ closure: (T) -> ()) -> UICollectionViewCell {
        switch constructor() {
        case .some(let unwrapped):
            closure(unwrapped)
            return unwrapped
        case .none:
            return UICollectionViewCell()
        }
    }
}
