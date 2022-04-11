//
//  NetworkError.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    enum RequestBuildingFailureType {
        case noURL(EndPointType)
        case error(Error, EndPointType)
        case urlComponentsBuildingFailure(URL?)
        case sessionTokenMissing
    }
    
    case text(String)
    case codingFailure(Error)
    case uploadError(Error)
    case urlError(URLError)
    case requestFailure(Error, EndPointType)
    case requestBuildingFailure(RequestBuildingFailureType)
    case statusCodeInaccaptableParsed(code: Int, backendError: NetworkErrorDetails)
    case statusCodeInaccaptable(code: Int)
    case unauthorized(backendError: NetworkErrorDetails?)
    case noResponse
    case never // helper

    var description: String {
        switch self {
        case let .text(value):
            return value
        case let .codingFailure(error):
            return  """
                    Coding failed.
                    Error: ----------
                    \(error)
                    -----------------
                    """
        case let .uploadError(error):
            return """
                    Upload failed.
                    Error: ----------
                    \(error)
                    -----------------
                   """
        case let .urlError(error):
            return  """
                    Request failed with URL error.
                    Error: ----------
                    \(error)
                    -----------------
                    """
        case let .requestFailure(error, endPoint):
            return  """
                    Request failed.
                    Method: \(endPoint.httpMethod)
                    Path: \(endPoint.path)
                    Error: ----------
                    \(error)
                    -----------------
                    """
        case let .requestBuildingFailure(failureType):
            switch failureType {
            case let .noURL(endPoint):
                return  """
                        Request building failed. URL was nil.
                        Method: \(endPoint.httpMethod)
                        Path: \(endPoint.path)
                        """
            case let .error(error, endPoint):
                return  """
                        Request building failed.
                        Method: \(endPoint.httpMethod)
                        Path: \(endPoint.path)
                        Error: ----------
                        \(error)
                        -----------------
                        """
            case let .urlComponentsBuildingFailure(url):
                return "Request building failed. Unable to build URLComponents from URL: " + (url?.absoluteString ?? "nil")
            case .sessionTokenMissing:
                return "Session token is missing."
            }
        case let .statusCodeInaccaptableParsed(code, backendError):
            return  """
                    >>> Status code: \(code)
                    >>> Error: \(backendError)
                    """
        case let .statusCodeInaccaptable(code):
            return  """
                    >>> Status code inacceptable: \(code)
                    """
        case .unauthorized:
            return ">>> User not authorized."
        case .noResponse:
            return ">>> Could not receive a response."
        case .never:
            return ""
        }
    }
    
    var isRetryAvailable: Bool {
        switch self {
        case .statusCodeInaccaptable(let code),
             .statusCodeInaccaptableParsed(let code, _):
            switch code {
            case ...0:  return true
            default:    return false
            }
        case let .urlError(error):
            switch error.code {
            case .timedOut,
                 .networkConnectionLost,
                 .cannotConnectToHost,
                 .notConnectedToInternet:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
    
    var statusCode: Int? {
        switch self {
        case .statusCodeInaccaptable(let code),
             .statusCodeInaccaptableParsed(let code, _):
            return code
        default:
            return nil
        }
    }
}


