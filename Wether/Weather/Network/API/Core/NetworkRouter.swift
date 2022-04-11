//
//  NetworkRouter.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Combine
import Foundation

typealias ResponseInfo = (data: Data, urlResponse: URLResponse)
typealias UploadProgress = Double
typealias UploadInfo<T> = (progress: UploadProgress?, response: T?)

// MARK: - Errors
struct NetworkErrorDetails: Decodable {
    let error: String?
    let message: String?
}

// MARK: - MediaRequestParameter
struct MediaRequestParameter {
    
    enum MimeType: String, Codable {
        case imageJpeg = "image/jpeg"
        case imagePng = "image/png"
        
        var fileExtension: String {
            switch self {
            case .imageJpeg:    return "jpg"
            case .imagePng:     return "png"
            }
        }
    }
    
    enum Key: String, Codable {
        case cover
        case avatar
        case postPhotos = "post_photos[]"
        case file
    }
    
    let id: UUID
    let data: Data
    let mimeType: MimeType
    let key: Key?
    let fileName: String
    
    init(_ data: Data, mimeType: MimeType, key: Key = .file, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.data = data
        self.key = key
        self.mimeType = mimeType
        self.fileName = self.id.uuidString + "." + mimeType.fileExtension
    }
}

// MARK: - NetworkRouter
struct NetworkRouter<EndPoint: EndPointType> {
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// Request with parameters as Dictionary with empty response data
    func makeDefaultRequest(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        parameters: Parameters = [:],
        extraHeaders: HTTPHeaders? = nil,
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<URLResponse, NetworkError>
    {
        getDefaultResponse(
            request: buildRequest(route: endpoint, query: queryItems, dictionary: parameters, extraHeaders: extraHeaders),
            endpoint: endpoint,
            subscribeOn: subscribeOn,
            receiveOn: receiveOn
        )
    }
    
    /// Request with parameters as Codable with empty response data
    func makeDefaultRequest<ParametersType: Encodable>(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        parameters: ParametersType,
        extraHeaders: HTTPHeaders? = nil,
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<URLResponse, NetworkError>
    {
        getDefaultResponse(
            request: buildRequest(route: endpoint, query: queryItems, encodable: parameters, extraHeaders: extraHeaders),
            endpoint: endpoint,
            subscribeOn: subscribeOn,
            receiveOn: receiveOn
        )
    }
    
    /// Request with parameters as Dictionary with data in response
    func makeDataRequest<ResponseType: Decodable>(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        parameters: Parameters = [:],
        extraHeaders: HTTPHeaders? = nil,
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<ResponseType, NetworkError>
    {
        getDataResponse(
            request: buildRequest(route: endpoint, query: queryItems, dictionary: parameters, extraHeaders: extraHeaders),
            endpoint: endpoint,
            subscribeOn: subscribeOn,
            receiveOn: receiveOn
        )
    }
    
    /// Request with parameters as Codable with data in response
    func makeDataRequest<ParametersType: Encodable, ResponseType: Decodable>(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        parameters: ParametersType,
        extraHeaders: HTTPHeaders? = nil,
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<ResponseType, NetworkError>
    {
        getDataResponse(
            request: buildRequest(route: endpoint, query: queryItems, encodable: parameters, extraHeaders: extraHeaders),
            endpoint: endpoint,
            subscribeOn: subscribeOn,
            receiveOn: receiveOn
        )
    }
    
    /// Multipart Request with parameters as Dictionary and Decodable in response
    func makeDataMultipartRequest<ResponseType: Decodable>(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        extraHeaders: HTTPHeaders? = nil,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String = "Boundary-\(UUID().uuidString)",
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<ResponseType, NetworkError>
    {
        return makeBasicUploadRequest(
            endpoint,
            queryItems: queryItems,
            extraHeaders: extraHeaders,
            parameters: parameters,
            mediaParameters: mediaParameters,
            boundary: boundary,
            subscribeOn: subscribeOn
        )
            .compactMap(\.response?.data)
            .flatMap { data -> Future<ResponseType, NetworkError> in
                decodeData(data: data)
            }
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    
    /// Multipart Request with parameters as Dictionary and empty response
    func makeDefaultMultipartRequest(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        extraHeaders: HTTPHeaders? = nil,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String = "Boundary-\(UUID().uuidString)",
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<URLResponse, NetworkError>
    {
        return makeBasicUploadRequest(
            endpoint,
            queryItems: queryItems,
            extraHeaders: extraHeaders,
            parameters: parameters,
            mediaParameters: mediaParameters,
            boundary: boundary,
            subscribeOn: subscribeOn
        )
            .compactMap(\.response?.urlResponse)
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    
    /// Multipart Request with parameters as Dictionary, progress tracking and Decodable in response
    func makeDataUploadRequest<ResponseType: Decodable>(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        extraHeaders: HTTPHeaders? = nil,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String = "Boundary-\(UUID().uuidString)",
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<UploadInfo<ResponseType>, NetworkError>
    {
        return makeBasicUploadRequest(
            endpoint,
            queryItems: queryItems,
            extraHeaders: extraHeaders,
            parameters: parameters,
            mediaParameters: mediaParameters,
            boundary: boundary,
            subscribeOn: subscribeOn
        )
            .flatMap { progress, response -> AnyPublisher<UploadInfo<ResponseType>, NetworkError> in
                guard let data = response?.data else { return just((progress, nil)) }
                
                return decodeData(data: data)
                    .map { (progress, $0) }
                    .eraseToAnyPublisher()
            }
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    
    /// Multipart Request with parameters as Dictionary, progress tracking and empty response
    func makeDefaultUploadRequest(
        _ endpoint: EndPoint,
        queryItems: [String : String] = [:],
        extraHeaders: HTTPHeaders? = nil,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String = "Boundary-\(UUID().uuidString)",
        subscribeOn: DispatchQueue = .global(qos: .default),
        receiveOn: DispatchQueue = .main
    )
        -> AnyPublisher<UploadInfo<URLResponse>, NetworkError>
    {
        return makeBasicUploadRequest(
            endpoint,
            queryItems: queryItems,
            extraHeaders: extraHeaders,
            parameters: parameters,
            mediaParameters: mediaParameters,
            boundary: boundary,
            subscribeOn: subscribeOn
        )
            .map { ($0, $1?.urlResponse) }
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    
    private func getDefaultResponse(
        request: AnyPublisher<URLRequest, NetworkError>,
        endpoint: EndPoint,
        subscribeOn: DispatchQueue,
        receiveOn: DispatchQueue
    ) -> AnyPublisher<URLResponse, NetworkError> {
        runRequest(request: request, endpoint: endpoint, subscribeOn: subscribeOn)
            .map(\.response)
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    
    private func getDataResponse<ResponseType: Decodable>(
        request: AnyPublisher<URLRequest, NetworkError>,
        endpoint: EndPoint,
        subscribeOn: DispatchQueue,
        receiveOn: DispatchQueue
    ) -> AnyPublisher<ResponseType, NetworkError> {
        runRequest(request: request, endpoint: endpoint, subscribeOn: subscribeOn)
            .flatMap { response in
                decodeData(data: response.data)
            }
            .receive(on: receiveOn)
            .eraseToAnyPublisher()
    }
    

    private func makeBasicUploadRequest(
        _ endpoint: EndPoint,
        queryItems: [String : String],
        extraHeaders: HTTPHeaders?,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String,
        subscribeOn: DispatchQueue
    )
        -> AnyPublisher<UploadInfo<ResponseInfo>, NetworkError>
    {
        let requestPublisher = buildRequest(
            route: endpoint,
            query: queryItems,
            dictionary: [:],
            extraHeaders: extraHeaders
        )
            .flatMap { [parameters, mediaParameters, boundary] request in
                return self.addMultipartBody(
                    to: request,
                    parameters: parameters,
                    mediaParameters: mediaParameters,
                    boundary: boundary
                )
            }
            .eraseToAnyPublisher()
        
        return runUploadRequest(
            request: requestPublisher,
            endpoint: endpoint,
            subscribeOn: subscribeOn
        )
    }
    
    private func runRequest(
        request: AnyPublisher<URLRequest, NetworkError>,
        endpoint: EndPoint,
        subscribeOn: DispatchQueue
    ) -> AnyPublisher<URLSession.DataTaskPublisher.Output, NetworkError> {
        request
            .subscribe(on: subscribeOn)
            .flatMap { request  in
                runRequest(request: request, endpoint: endpoint)
            }
            .eraseToAnyPublisher()
    }
    
    private func runUploadRequest(
        request: AnyPublisher<URLRequest, NetworkError>,
        endpoint: EndPoint,
        subscribeOn: DispatchQueue
    ) -> AnyPublisher<UploadInfo<ResponseInfo>, NetworkError> {
        request
            .subscribe(on: subscribeOn)
            .flatMap { request in
                runUploadRequest(request: request, endpoint: endpoint)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private
fileprivate extension NetworkRouter {
    private func runUploadRequest(
        request:  URLRequest,
        endpoint: EndPoint
    ) -> AnyPublisher<UploadInfo<ResponseInfo>, NetworkError> {
        return NetworkEnvironment
            .reachabilitySubject
            .first(where: { $0 }) // wait until network becomes reachable
            .setFailureType(to: NetworkError.self)
            .handleEvents(receiveOutput: { [request] _ in
                self.logRequest(request)
            })
            .flatMap { [request] _ in
                Publishers.UploadPublisher(for: request)
            }
            .flatMap({ uploadInfo -> AnyPublisher<UploadInfo<ResponseInfo>, NetworkError> in
                guard let (data, urlResponse) = uploadInfo.response else {
                    return just(uploadInfo)
                }
                
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    return fail(.text("Wrong response: \(urlResponse)"))
                }
                
                self.logResponse(data: data, response: urlResponse, httpResponse: httpResponse)

                switch httpResponse.statusCode {
                case 200..<300:
                    return just(uploadInfo)
                default:
                    let networkError = resolveInacceptableStatusCode(
                        route: endpoint,
                        code: httpResponse.statusCode,
                        data: data
                    )

                    return fail(networkError)
                }
            })
            .retryOnError(endpoint.isRetryImplied)
            .handleEvents(receiveCompletion: self.handleCompletion(_:))
            .eraseToAnyPublisher()
    }
    
    private func runRequest(
        request:  URLRequest,
        endpoint: EndPoint
    ) -> AnyPublisher<URLSession.DataTaskPublisher.Output, NetworkError> {
        
        return NetworkEnvironment
            .reachabilitySubject
            .first(where: { $0 }) // wait until network becomes reachable
            .setFailureType(to: URLError.self)
            .handleEvents(receiveOutput: { [request] _ in
                self.logRequest(request)
            })
            .flatMap { [request] _ in
                return URLSession.shared.dataTaskPublisher(for: request)
            }
            .mapError(NetworkError.urlError)
            .flatMap { result -> AnyPublisher<URLSession.DataTaskPublisher.Output, NetworkError> in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    return fail(.text("Wrong response: \(result.response)"))
                }
                
                self.logResponse(data: result.data, response: result.response, httpResponse: httpResponse)

                switch httpResponse.statusCode {
                case 200..<300:
                    return just(result)
                default:
                    let networkError = resolveInacceptableStatusCode(
                        route: endpoint,
                        code: httpResponse.statusCode,
                        data: result.data
                    )

                    return fail(networkError)
                }
            }
            .retryOnError(endpoint.isRetryImplied)
            .handleEvents(receiveCompletion: self.handleCompletion(_:))
            .eraseToAnyPublisher()
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        if case let .failure(error) = completion {
            print(error.description)
        }
    }
    
    private func logRequest(_ request: URLRequest) {
        let requestLog = """
        \n\n\n
        --- REQUEST START -----------------------------------
        TIME: \(Date())
        PATH: \(request.url?.absoluteString ?? "nil")
        METHOD: \(request.httpMethod ?? "nil")
        HEADERS: \(request.allHTTPHeaderFields ?? [:])
        BODY: \(request.httpBody?.prettyPrinted ?? "nil")
        --- REQUEST END -------------------------------------
        \n\n\n
        """
        print(requestLog)
    }
    
    private func logResponse(
        data: Data?,
        response: URLResponse?,
        httpResponse: HTTPURLResponse
    ) {
        let responseLog = """
        \n\n\n
        --- RESPONSE START ----------------------------------
        TIME: \(Date())
        PATH: \(response?.url?.absoluteString ?? "nil")
        STATUS CODE: \(httpResponse.statusCode)
        HEADERS: \(httpResponse.allHeaderFields.map({ (key, value) -> String in
            return "\(key as? String ?? "\(key)"): \(value as? String ?? "\(value)")"
        }))
        BODY: \(data?.prettyPrinted ?? "nil")
        --- RESPONSE END ------------------------------------
        \n\n\n
        """
        print(responseLog)
    }
    
    private func resolveInacceptableStatusCode(route: EndPoint, code: Int, data: Data) -> NetworkError {
        let decoder = jsonDecoder
        let backendError = try? decoder.decode(NetworkErrorDetails.self, from: data)
            
        switch code {
        case 401:
            return .unauthorized(backendError: backendError)
        default:
            if let backendError = backendError {
                return .statusCodeInaccaptableParsed(code: code, backendError: backendError)
            } else {
                return .statusCodeInaccaptable(code: code)
            }
        }
    }
    
    private func decodeData<ResponseType: Decodable>(data: Data)
        -> Future<ResponseType, NetworkError>
    {
        Future { promise in
            let decoder = jsonDecoder
            let result = Result { try decoder.decode(ResponseType.self, from: data) }
                .mapError(NetworkError.codingFailure)
            promise(result)
        }
    }
    
    private func just<OutputType>(_ value: OutputType) -> AnyPublisher<OutputType, NetworkError> {
        Just(value)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

    private func fail<OutputType>(_ NetworkError: NetworkError) -> AnyPublisher<OutputType, NetworkError> {
        Fail(
            outputType: OutputType.self,
            failure: NetworkError
        )
        .eraseToAnyPublisher()
    }
    
    func buildRequest<ResponseType: Encodable>(
        route: EndPoint,
        query: [String : String] = [:],
        encodable: ResponseType,
        extraHeaders: HTTPHeaders?
    )
        -> AnyPublisher<URLRequest, NetworkError>
    {
        buildBasicRequest(route: route, query: query, extraHeaders: extraHeaders)
            .flatMap { request in
                addJSONBody(to: request, encodable: encodable)
            }
            .eraseToAnyPublisher()
    }
    
    func buildRequest(
        route: EndPoint,
        query: [String : String] = [:],
        dictionary: Parameters,
        extraHeaders: HTTPHeaders?
    )
        -> AnyPublisher<URLRequest, NetworkError>
    {
        buildBasicRequest(route: route, query: query, extraHeaders: extraHeaders)
            .flatMap { request in
                addJSONBody(to: request, dictionary: dictionary)
            }
            .eraseToAnyPublisher()
    }
    
    private func buildBasicRequest(
        route: EndPoint,
        query: [String : String] = [:],
        extraHeaders: HTTPHeaders?
    )
        -> AnyPublisher<URLRequest, NetworkError>
    {
        Future<URLRequest, NetworkError> { promise in
            guard let url = route.baseUrl.flatMap({ URL(string: $0.absoluteString + route.path) }) else {
                promise(.failure(.requestBuildingFailure(.noURL(route))))
                return
            }
            
            var request = URLRequest(
                url: url,
                cachePolicy: route.cachePolicy,
                timeoutInterval: route.timeoutInterval
            )
            
            request.httpMethod = route.httpMethod.rawValue
            promise(.success(request))
        }
        .flatMap { request -> AnyPublisher<URLRequest, NetworkError> in
            return just(request)
        }
        .flatMap { request in
            addQuery(to: request, parameters: query)
        }
        .map { request in
            request
                .addHeaders(route.headers)
                .addHeaders(extraHeaders)
                .addCookies()
        }
        .eraseToAnyPublisher()
    }
    
    private func addQuery(to request: URLRequest, parameters: [String : String]) -> Future<URLRequest, NetworkError> {
        Future { promise in
            guard !parameters.isEmpty else {
                promise(.success(request))
                return
            }
            
            guard var components = request.url.flatMap({ url in
                URLComponents(url: url, resolvingAgainstBaseURL: true)
            }) else {
                promise(.failure(.requestBuildingFailure(.urlComponentsBuildingFailure(request.url))))
                return
            }
            
            var request = request
            
            components.queryItems = parameters.map { (key, value) in
                let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return URLQueryItem(name: key, value: encodedValue)
            }
            
            request.url = components.url
            promise(.success(request))
        }
    }
    
    private func addJSONBody<ParametersType: Encodable>(
        to request: URLRequest,
        encodable parameters: ParametersType
    )
        -> AnyPublisher<URLRequest, NetworkError>
    {
        return makeJSONBody(encodable: parameters)
            .map { [request] body -> URLRequest in
                var mutableRequest = request
                mutableRequest.httpBody = body
                mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                return mutableRequest
            }
            .eraseToAnyPublisher()
    }
    
    private func makeJSONBody<ParametersType: Encodable>(
        encodable parameters: ParametersType
    ) -> Future<Data, NetworkError> {
        Future { [parameters] promise in
            let result = Result { try jsonEncoder.encode(parameters) }
                .mapError(NetworkError.codingFailure)
            promise(result)
        }
    }
    
    private func addJSONBody(to request: URLRequest, dictionary parameters: Parameters)
        -> AnyPublisher<URLRequest, NetworkError>
    {
        guard !parameters.isEmpty else { return just(request) }
        
        return makeJSONBody(dictionary: parameters)
            .map { [request] body -> URLRequest in
                var mutableRequest = request
                mutableRequest.httpBody = body
                mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                return mutableRequest
            }
            .eraseToAnyPublisher()
    }
    
    private func makeJSONBody(
        dictionary parameters: Parameters
    ) -> Future<Data, NetworkError> {
        Future { [parameters] promise in
            let result = Result { try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) }
                .mapError(NetworkError.codingFailure)
            
            promise(result)
        }
    }
    
    private func addMultipartBody(
        to request: URLRequest,
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String
    )
        -> Future<URLRequest, NetworkError>
    {
        Future { promise in
            var mutableRequest = request
            mutableRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            mutableRequest.httpBody = makeMultipartBody(
                parameters: parameters,
                mediaParameters: mediaParameters,
                boundary: boundary
            )
            
            promise(.success(mutableRequest))
        }
    }
    
    private func makeMultipartBody(
        parameters: Parameters,
        mediaParameters: [MediaRequestParameter],
        boundary: String
    ) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }

        for mediaParameter in mediaParameters {
            guard let key = mediaParameter.key?.rawValue else {
                      continue
                  }
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(mediaParameter.fileName)\"\r\n")
            body.appendString("Content-Type: \(mediaParameter.mimeType.rawValue)\r\n\r\n")
            body.append(mediaParameter.data)
            body.appendString("\r\n")
        }
        
        if mediaParameters.isEmpty == false {
            body.appendString("--\(boundary)--")
        }

        return body as Data
    }
}

// MARK: - NSMutableData extension
fileprivate extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}

fileprivate extension URLRequest {
    func addHeaders(_ headers: HTTPHeaders?) -> Self {
        guard let headers = headers else { return self }
        
        var request = self
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func addCookies() -> Self {
        guard
            let url = url,
            let cookies = HTTPCookieStorage.shared.cookies(for: url)
        else {
            return self
        }
        
        return self.addHeaders(HTTPCookie.requestHeaderFields(with: cookies))
    }
}
