//
//  Atomic.swift
//  Admin
//
//  Created by Petro Poroshenko on 11.02.2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation

@propertyWrapper
public final class Atomic<Wrapped> {
    private let lock: NSLocking
    private var _value: Wrapped
    
    public var wrappedValue: Wrapped {
        get { self.getValue { $0 } }
        set { self.setValue { $0 = newValue } }
    }
    
    public init(wrappedValue: Wrapped, lock: NSRecursiveLock = NSRecursiveLock()) {
        self._value = wrappedValue
        self.lock = lock
    }
    
    private func lockedAction<Wrapped>(_ execute: () -> Wrapped) -> Wrapped {
        self.lock.lock()
        defer { self.lock.unlock() }
        
        return execute()
    }
    
    private func setValue(_ action: (inout Wrapped) -> Void) {
        self.lockedAction { action(&_value) }
    }
    
    private func getValue(_ action: (Wrapped) -> Wrapped) -> Wrapped {
        self.lockedAction { action(self._value) }
    }
}
