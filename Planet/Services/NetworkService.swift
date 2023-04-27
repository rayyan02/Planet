//
//  NetworkService.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 24/04/2023.
//

import Foundation

struct NetworkConstants {
    public static let baseURL = "https://swapi.dev/api/"
}

enum NetworkError: Error {
    case badURL
    case noData
    case error
}

/// Request generate model
struct Request {
    let url: String?
}

/// Response model
struct Response {
    let error : Error?
    let data : Data?
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

final class NetworkService {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session  = session
    }
    
    typealias onCompletion = ((_ response : Response?) -> Void)
    
    /// Server method to send or get the data
    /// - Parameters:
    ///   - request: request
    ///   - onCompletion: response block
    func dataTask(request: Request, onCompletion:@escaping onCompletion) {
        guard let stringURL = request.url,let serverURL = URL(string: stringURL) else {
            return
        }
        let urlRequest = URLRequest(url: serverURL)
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data,response,error) in
            if error != nil {
                onCompletion(nil)
            }
            guard let responseData = data else {
                return  onCompletion(nil)
            }
            
            let responseModel = Response(error: error, data: responseData)
            onCompletion(responseModel)
        })
        task.resume()
    }
}
