//  MockURLSession.swift
//  PlanetAppTests
//
//  Created by Syed Rayyan Hasnain on 27/04/2023.
//

import Foundation

class MockURLSession: URLSessionProtocol {

    var dataTask = MockURLSessionDataTask()
    var mockData: Data?
    var error: Error?
    
    private (set) var mockURL: String?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        mockURL = request.url?.absoluteString
        
        completionHandler(mockData, successHttpURLResponse(request: request), error)
        return dataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
