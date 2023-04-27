//
//  NetworkServiceTests.swift
//  PlanetAppTests
//
//  Created by Syed Rayyan Hasnain on 27/04/2023.
//

import XCTest

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService(session: session)
    }
    
    
    func test_should_return_correct_url() {
        let requestURL = "https://swapi.dev/api/Planets"
        let request = Request(url: requestURL)
        networkService.dataTask(request: request) { response in
            //
        }
        XCTAssert(session.mockURL == requestURL)
    }
    
    func test_should_return_correct_data() {
        let requestURL = "https://swapi.dev/api/Planets"
        let request = Request(url: requestURL)
        let expected = "{test: '1'}".data(using: .utf8)
        session.mockData = expected
        var recievedData: Data?
        networkService.dataTask(request: request) { response in
            recievedData = response?.data
        }
        XCTAssertNotNil(recievedData)
    }
    
}
