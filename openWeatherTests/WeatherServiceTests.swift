//
//  openWeatherTests.swift
//  openWeatherTests
//
//  Created by Nguyen Loc on 3/3/22.
//

import XCTest
@testable import openWeather

class WeatherServiceTests: XCTestCase {
    let apiService = WeatherService()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityNotFound() throws {
        let expectation = XCTestExpectation(description: "Waiting for api request")
        apiService.getDailyForecast(term: "abc") { result in
            switch result {
            case .success(let response):
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertEqual(error.cod, "404")
                expectation.fulfill()
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCityFound() throws {
        let expectation = XCTestExpectation(description: "Waiting for api request")
        apiService.getDailyForecast(term: "saigon") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
