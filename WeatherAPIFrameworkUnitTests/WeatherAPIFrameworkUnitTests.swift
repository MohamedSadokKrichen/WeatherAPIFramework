//
//  WeatherAPIFrameworkUnitTests.swift
//  WeatherAPIFrameworkUnitTests
//
//  Created by Mohamed Sadok  Krichen on 14/03/2023.
//

import XCTest
@testable import WeatherAPIFramework

final class WeatherAPIFrameworkUnitTests: XCTestCase {
    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestURLCreation() throws {
        let wfRequest = WFRequest(endPoint: .weather)
        let url = wfRequest.url?.absoluteString
        let expectedURL = "https://api.openweathermap.org/data/2.5/weather"
        XCTAssertTrue(url == expectedURL)
    }
    
    func testRequestParametersCreation() throws {
        let queryParameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "Paris"),
            URLQueryItem(name: "appid", value: Constants.apiKey),
            URLQueryItem(name: "units", value: Units.metric.rawValue)
        ]
        let request = WFRequest(endPoint: .weather, queryParameters: queryParameters)
        let finalUrl = request.url?.absoluteString ?? ""
        let expectedUrl = "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=975365616f8e7f77a169c4f33bd8438c&units=metric"
        
        XCTAssertTrue(finalUrl == expectedUrl)
    }
    
    func testAPIClient() throws {
        let expectation = self.expectation(description: "Weather response parsed")
        WeatherApiCalls.shared.getWeatherInfo(for: "Paris") { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10.0)
    }

}
