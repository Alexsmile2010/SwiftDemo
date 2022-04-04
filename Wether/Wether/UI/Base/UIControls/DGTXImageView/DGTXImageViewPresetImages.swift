//
//  DGTXImageViewPresetImages.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 01.07.2021.
//

import Foundation
import UIKit

enum DGTXImagePresetImages {
    case search
}




extension DGTXImagePresetImages {
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(named: "search")
        }
    }
}
