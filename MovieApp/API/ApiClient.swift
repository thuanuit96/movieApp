//
//  ApiClient.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//


import Foundation

protocol ApiRequest {    
    var request: URLRequest? { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [String : String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
}
extension ApiRequest {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return AppConfig.hostname
    }
    
    var port: Int {
        return 443
    }
    
    var httpHeaders: [String : String]? {
        let headers = ["Content-Type": "application/json"];
//        if token.isEmpty == false {
//            headers["Authorization"] = "Bearer \(token)"
//        }
        return headers
    }
    
    func request(forEndpoint endpoint: String) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        urlComponents.port = port
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    func request<T: Encodable>(forEndpoint endpoint: String, body: T) -> URLRequest? {
        var r = request(forEndpoint: endpoint)
        r?.httpBody = try? JSONEncoder().encode(body)
        
        return r
    }
}

enum EndpointPaths : String {
    case fetchMove = "/3/discover/movie"
}

public enum HTTPMethod : String {
    case GET
    case POST
    case DELETE
    case PUT
    case HEAD
    case CONNECT
    case OPTIONS
    case TRACE
}

public protocol GenericError : Codable {
    var code: String { get set }
    var message: String { get set }
}




protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<T>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    // MARK: - ApiClient
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<T>) -> Void) {
        
        let dataTask = urlSession.dataTask(with: request.request!) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                completionHandler(.success(ApiResponse(data: data, httpUrlResponse: httpUrlResponse) as! T))
            } else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
