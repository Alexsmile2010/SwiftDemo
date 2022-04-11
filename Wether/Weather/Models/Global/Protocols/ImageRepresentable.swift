//
//  ImageRepresentable.swift
//  DGTX
//
//  Created by Volodymyr Ludchenko on 11.06.2021.
//

import UIKit

protocol ImageRepresentable {
    var image: UIImage? { get }
}

extension ImageRepresentable where Self: RawRepresentable, Self.RawValue == String {
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
