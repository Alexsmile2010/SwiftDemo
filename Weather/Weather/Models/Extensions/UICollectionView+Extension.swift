//
//  UICollectionView+Extension.swift
//  DGTX
//
//  Created by Alexey Zayakin on 11.05.2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeue<T: UICollectionViewCell>(_ withClass: T.Type, for indexPath: IndexPath)  -> CollectionCellContainer<T> {
        return CollectionCellContainer({ [weak self] in
            self?.dequeueReusableCell(withReuseIdentifier: String(describing: withClass), for: indexPath) as? T
        })
    }
    
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}
