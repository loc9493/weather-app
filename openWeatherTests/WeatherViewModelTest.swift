//
//  WeatherViewModelTest.swift
//  openWeatherTests
//
//  Created by Nguyen Loc on 3/4/22.
//

import XCTest
@testable import openWeather

class WeatherViewModelTest: XCTestCase {
    private var forecastObserver: NSKeyValueObservation?
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckValidTerm() throws {
        let viewModel = WeatherViewModel()
        let inputs = ["a", "0", "abc", "cdef", "def", "12312"];
        for term in inputs {
            if (term.count >= 3) {
                XCTAssertTrue(viewModel.isValidTerm(term: term))
            } else {
                XCTAssertFalse(viewModel.isValidTerm(term: term))
            }
        }
    }
    
    func testCheckHasResponse() throws {
        let viewModel = WeatherViewModel()
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.forecastDay)
        let expectation = XCTestExpectation(description: "Waiting for api request")
        viewModel.getCityForecast(term: "saigon")
        XCTAssertTrue(viewModel.isLoading)
        forecastObserver = viewModel.observe(\WeatherViewModel.forecastDay, options: .new, changeHandler: {model, info in
            XCTAssertFalse(model.isLoading)
            XCTAssertNil(model.errorMessage)
            XCTAssertNotNil(model.forecastDay)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNotFoundResponse() throws {
        let viewModel = WeatherViewModel()
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.forecastDay)
        let expectation = XCTestExpectation(description: "Waiting for api request")
        viewModel.getCityForecast(term: "abc")
        XCTAssertTrue(viewModel.isLoading)
        forecastObserver = viewModel.observe(\WeatherViewModel.errorMessage, options: .new, changeHandler: {model, info in
            XCTAssertFalse(model.isLoading)
            XCTAssertNotNil(model.errorMessage)
            XCTAssertNil(model.forecastDay)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNoDataViewModel() throws {
        let viewModel = WeatherViewModel()
        XCTAssertEqual(viewModel.numberOfSection(), 1)
        XCTAssertEqual(viewModel.numberOfRows(section: 0), 0)
        XCTAssertNil(viewModel.forecastAtIndex(index: 0))
    }
    
    func testViewModelHasData() throws {
        let viewModel = WeatherViewModel()
        let expectation = XCTestExpectation(description: "Waiting for api request")
        viewModel.getCityForecast(term: "saigon")
        forecastObserver = viewModel.observe(\WeatherViewModel.forecastDay, options: .new, changeHandler: {model, info in
            XCTAssertNotNil(model.forecastDay)
            XCTAssertEqual(viewModel.numberOfSection(), 1)
            XCTAssertEqual(viewModel.numberOfRows(section: 0), 7)
            XCTAssertNotNil(viewModel.forecastAtIndex(index: 0))
            XCTAssertNotNil(viewModel.forecastAtIndex(index: 4))
            XCTAssertNil(viewModel.forecastAtIndex(index: 7))
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() throws {
        
        self.measure {
        }
    }

}
