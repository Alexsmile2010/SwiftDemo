//
//  Publishers+RetryInfinite.swift
//  DGTX
//
//  Created by Volodymyr Ludchenko on 17.06.2021.
//

import Foundation
import Combine


extension Publishers {
    struct RetryInfinite<Upstream: Publisher>: Publisher {
        typealias Output = Upstream.Output
        typealias Failure = Never
        
        private let upstream: Upstream
        private let delay: TimeInterval
        private let scheduler = DispatchQueue(label: "RetryInfinite.Scheduler.\(UUID().uuidString)", qos: .userInteractive)
        
        init(upstream: Upstream, delay: TimeInterval) {
            self.upstream = upstream
            self.delay = delay
        }
        
        func receive<S: Subscriber>(subscriber: S)
        where S.Failure == Never,
              S.Input == Upstream.Output
        {
            self.upstream
                .catch { error -> AnyPublisher<Output, Failure> in
                    if delay == 0 {
                        return self.upstream
                            .retryInfinite(delay: 0)
                            .eraseToAnyPublisher()
                    } else {
                        return self.upstream
                            .delay(for: .seconds(delay), scheduler: self.scheduler, options: .none)
                            .retryInfinite(delay: 0)
                            .eraseToAnyPublisher()
                    }
                }
                .subscribe(subscriber)
        }
    }
}

extension Publisher {
    func retryInfinite(delay: TimeInterval) -> Publishers.RetryInfinite<Self> {
        Publishers.RetryInfinite<Self>.init(
            upstream: self,
            delay: delay
        )
    }
}
