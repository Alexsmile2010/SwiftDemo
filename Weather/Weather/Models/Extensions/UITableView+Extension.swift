//
//  UITableView+Extension.swift
//  DGTX
//
//  Created by Alexey Zayakin on 12.04.2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerClass<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeue<T: UITableViewCell>(_ withClass: T.Type, for indexPath: IndexPath) -> TableCellContainer<T> {
        return TableCellContainer({ [weak self] in
            self?.dequeueReusableCell(withIdentifier: String(describing: withClass), for: indexPath) as? T
        })
    }
}
