//
//  Publishers+UploadPublisher.swift
//  Blockster
//
//  Created by Volodymyr Ludchenko on 19.10.2021.
//

import Foundation
import Combine


extension Publishers {
    
    // MARK: - UploadPublisher
    struct UploadPublisher: Publisher {
        typealias Output = UploadInfo<(data: Data, urlResponse: URLResponse)>
        typealias Failure = NetworkError
        
        // MARK: - Private properties
        private let request: URLRequest
        
        // MARK: - Life Cycle
        init(for request: URLRequest) {
            self.request = request
        }
        
        // MARK: - Publisher requirements
        func receive<S>(subscriber: S) where S : Subscriber, S.Failure == NetworkError, S.Input == UploadInfo<(data: Data, urlResponse: URLResponse)>
        {
            let subscription = UploadTaskSubscription(subscriber: subscriber, request: request)
            subscriber.receive(subscription: subscription)
            subscription.resumeTask()
        }
    }
    
    
    // MARK: - UploadTaskSubscription
    private final class UploadTaskSubscription<S: Subscriber>: Subscription where S.Input == UploadInfo<(data: Data, urlResponse: URLResponse)>, S.Failure == NetworkError {
        
        // MARK: - Private properties
        private var subscriber: S?
        private var task: URLSessionUploadTask?
        private var cancellable: AnyCancellable?
        
        // MARK: - Life Cycle
        init(subscriber: S, request: URLRequest) {
            Swift.print("UploadTaskSubscription init")
            createTask(for: request)
            subscribe()
            self.subscriber = subscriber
        }
        
        // MARK: - Subscriber requirements
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            task?.cancel()
            task = nil
            subscriber = nil
            cancellable?.cancel()
            cancellable = nil
        }
        
        // MARK: - Public Methods
        func resumeTask() {
            task?.resume()
        }
        
        // MARK: - Private Methods
        private func createTask(for request: URLRequest) {
            task = UploadProcessor.shared.session.uploadTask(with: request, from: nil) { [weak self] data, response, error in
                if let response = response {
                    _ = self?.subscriber?.receive((nil, (data ?? Data(), response)))
                    self?.subscriber?.receive(completion: .finished)
                } else if let error = error {
                    self?.subscriber?.receive(completion: .failure(.uploadError(error)))
                } else {
                    self?.subscriber?.receive(completion: .failure(.noResponse))
                }
            }
        }
        
        private func subscribe() {
            guard let taskId = task?.taskIdentifier else { return }
            
            cancellable = UploadProcessor
                .shared
                .progressSubject
                .filter { [taskId] id, _ in
                    taskId == id
                }
                .map { _, progress in
                    progress
                }
                .sink { [weak self] progress in
                    _ = self?.subscriber?.receive(UploadInfo(progress, nil))
                }
        }
    }
    
    // MARK: - UploadProcessor
    private final class UploadProcessor: NSObject, URLSessionTaskDelegate {
        // MARK: - Public properties
        let progressSubject = PassthroughSubject<(Int, UploadProgress), Never>()
        lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        // MARK: - Singleton
        static let shared = UploadProcessor()
        
        // MARK: - Init
        private override init() {
            super.init()
        }
        
        // MARK: - URLSessionTaskDelegate
        func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
            let currentProgress = task.progress.fractionCompleted
            
            progressSubject.send((task.taskIdentifier, currentProgress))
        }
    }
}
