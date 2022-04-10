//
//  AppLayout.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit

enum AppLayout {
    case sideSpace(AppLayoutSideSpacing)
    case betwennItemSpace(AppLayoutBetweenItemSpaceing)
    case itemHeight(ItemHeight)
    case cornerRadius(AppLayoutCornerRadius)
    case cellHeight(CellHeight)
    case custom(value: CGFloat)
}

extension AppLayout {
    var value: CGFloat {
        switch self {
        case .betwennItemSpace(let spacing):
            return spacing.rawValue
        case .sideSpace(let spacing):
            return spacing.rawValue
        case .itemHeight(let value):
            return value.rawValue
        case .cellHeight(let value):
            return value.rawValue
        case .cornerRadius(let value):
            return value.rawValue
        case .custom(let value):
            return value
        }
    }
    
    static func +(_ lhs: AppLayout, _ rhs: AppLayout) -> AppLayout {
        return .custom(value: lhs.value + rhs.value)
    }
    
    static func -(_ lhs: AppLayout, _ rhs: AppLayout) -> AppLayout {
        return .custom(value: lhs.value - rhs.value)
    }
    
    // Unary minus
    static prefix func -(offset: AppLayout) -> AppLayout {
        return .custom(value: -offset.value)
    }
}


enum AppLayoutSideSpacing: CGFloat {
    /// equal: 0.0
    case zero = 0.0
    /// equal: 4.0
    case small = 4.0
    /// equal:8.0
    case medium = 8.0
    /// equal: 12.0
    case large = 12.0
}

enum AppLayoutBetweenItemSpaceing: CGFloat {
    
    /// equal: 0.0
    case zero = 0.0
    /// equal: 4.0
    case small = 4.0
    /// equal: 8.0
    case medium = 8.0
}

enum ItemHeight: CGFloat {
    
    /// equal: 1.0
    case separatorHeight = 1.0
    /// equal: 44.0
    case buttonHeight = 44.0
    ///equal: 72
    case hourlyCollectionViewHeight = 80.0
    ///equal: 15
    case hourlyCellLabelHeight = 15.0
}

enum AppLayoutCornerRadius: CGFloat {
    
    /// equal: 2.0
    case extraSmall = 2.0
    /// equal: 4.0
    case small = 4.0
    /// equal: 8.0
    case medium = 8.0
    /// equal: 16.0
    case large = 16.0
}

enum CellHeight: CGFloat {
    
    /// equal: 30.0
    case small = 30.0
}

