//
//  Publishers+staticStore.swift
//  Blockster
//
//  Created by Volodymyr Ludchenko on 22.10.2021.
//

import Foundation
import Combine

extension GlobalPublishers {
    static var bag: Set<AnyCancellable> = []
}

extension Cancellable {
    /// Stores Subscription in GlobalPublishers.bug
    func store() {
        self.store(in: &GlobalPublishers.bag)
    }
}
