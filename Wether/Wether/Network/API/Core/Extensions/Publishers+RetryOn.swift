//
//  Publishers+RetryOn.swift
//  Admin
//
//  Created by Petro Poroshenko on 11.02.2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation
import Combine

extension Publishers {
    struct RetryOn<Upstream: Publisher>: Publisher where Upstream.Failure == NetworkError {
        typealias Output = Upstream.Output
        typealias Failure = NetworkError
        
        let upstream: Upstream
        let delays: [TimeInterval]
        let scheduler: DispatchQueue
        
        init(upstream: Upstream, delays: [TimeInterval], scheduler: DispatchQueue) {
            self.upstream = upstream
            self.delays = delays
            self.scheduler = scheduler
        }
        
        func receive<S: Subscriber>(subscriber: S)
        where S.Failure == Upstream.Failure,
              S.Input == Upstream.Output
        {
            self.upstream
                .catch { error -> AnyPublisher<Output, Failure> in
                    guard error.isRetryAvailable, !self.delays.isEmpty else {
                        return Fail<Output, Failure>(error: error)
                            .eraseToAnyPublisher()
                    }
                    
                    // Recalculate future delays by subtracting the current one.
                    // The delay time of the next attempt is equal to the sum
                    // of the current delay time and a number from the array.
                    var newDelays = delays
                    let currentDelay = newDelays.removeFirst()
                    newDelays = newDelays.map { $0 - currentDelay }
                    
                    return self.upstream
                        .delay(for: .seconds(currentDelay), scheduler: scheduler, options: .none)
                        .retryOnError(delays: newDelays, scheduler: scheduler)
                        .eraseToAnyPublisher()
                }
                .subscribe(subscriber)
        }
    }
}

extension Publisher where Self.Failure == NetworkError {
    fileprivate func retryOnError(delays: [TimeInterval], scheduler: DispatchQueue) -> Publishers.RetryOn<Self> {
        return .init(
            upstream: self,
            delays: delays,
            scheduler: scheduler
        )
    }
    
    func retryOnError(_ isRetryImplied: Bool = true) -> AnyPublisher<Self.Output, NetworkError> {
        if isRetryImplied {
            let scheduler = DispatchQueue(
                label: "RetryOn.delayScheduler.\(UUID().uuidString)",
                qos: .userInteractive
            )
            
            return Publishers.RetryOn<Self>.init(
                upstream: self,
                delays: [2.0, 3.0, 5.0, 8.0].map(jittered),
                scheduler: scheduler
            )
            .eraseToAnyPublisher()
            
        } else {
            return self.eraseToAnyPublisher()
        }
    }
    
    // Randimizes time intervals for retrying
    fileprivate func jittered(_ interval: TimeInterval) -> TimeInterval {
        let intervalMilliseconds = Int(interval * 1000)
        let lowerBound = Swift.min(500, intervalMilliseconds)
        let driftMagnitude = Swift.max((intervalMilliseconds / 5), lowerBound)
        let drift = Int.random(in: -driftMagnitude...driftMagnitude)
        
        return TimeInterval((intervalMilliseconds + drift)) / 1000.0
    }
}
