//
//  openWeatherTests.swift
//  openWeatherTests
//
//  Created by Nguyen Loc on 3/3/22.
//

import XCTest
import RxSwift
@testable import openWeather

class openWeatherTests: XCTestCase {
    let apiService = WeatherService()
    let disposeBag = DisposeBag()
    override func setUpWithError() throws {
        print("Run teeee")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityNotFound() throws {
        let expectation = XCTestExpectation(description: "Waiting for api request")

        apiService.getDailyForecast(term: "abc") { result in
            switch result {
            case .success(let response):
                print("HEeee")
                expectation.fulfill()
                break
            case .failure(let error):
                print(error)
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
