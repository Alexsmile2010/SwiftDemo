//
//  SnapKit+Extension.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import Foundation
import SnapKit


extension ConstraintMakerEditable {
    
    @discardableResult
    func offset(_ layout: AppLayout) -> ConstraintMakerEditable {
        return self.offset(layout.value)
    }
    
    @discardableResult
    func inset(_ layout: AppLayout) -> ConstraintMakerEditable {
        return self.inset(layout.value)
    }
}

extension ConstraintMakerRelatable {
    
    @discardableResult
    func equalTo(_ layout: AppLayout) -> ConstraintMakerEditable {
        return self.equalTo(layout.value)
    }
    
    @discardableResult
    func lessThanOrEqualTo(_ layout: AppLayout) -> ConstraintMakerEditable {
        return self.lessThanOrEqualTo(layout.value)
    }
    
    @discardableResult
    func greaterThanOrEqualTo(_ layout: AppLayout) -> ConstraintMakerEditable {
        return self.greaterThanOrEqualTo(layout.value)
    }
}
