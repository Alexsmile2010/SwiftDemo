//
//  EndPointType.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var isAuthorizationRequired: Bool { get }
    var isTokensRefreshImplied: Bool { get }
    var apiVersion: String { get }
    var isRetryImplied: Bool { get }
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension EndPointType {
    var apiVersion: String {
        return "v1"
    }
    var isRetryImplied: Bool { return self.httpMethod == .get }
    var timeoutInterval: TimeInterval { return 10.0 }
    var cachePolicy: URLRequest.CachePolicy {
        return self.httpMethod == .get
            ? .reloadRevalidatingCacheData
            : .reloadIgnoringLocalAndRemoteCacheData
    }
}
