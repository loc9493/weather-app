//
//  WeatherViewModel.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

@objc class WeatherViewModel: NSObject {
    private let weatherService = WeatherService()
    private let reqProvider = RequestProvider(baseUrl: Constant.baseUrl, apiKey: Constant.apiKey() ?? "")
    @objc dynamic var isLoading = false
    @objc dynamic var forecastDay: ForecastResponse?
    @objc dynamic var errorMessage: String?
    func getCityForecast(term: String) {
        isLoading = true
        weatherService.getDailyForecast(term: term, completion: {[weak self] result in
            self?.isLoading = false
            switch result {
            case .failure(let error):
                self?.errorMessage = error.message
                break
            case .success(let response):
                self?.forecastDay = response
                break
            }
            
        })
    }
    
    func isValidTerm(term: String) -> Bool {
//    params: ["q": term, "cnt": "7", "unit":"metric"]
        if let request = reqProvider?.createRequest(endPoint: .dailyForecast, params: ["q": term, "cnt": "7", "unit":"metric"]) {
            let response = URLSession.shared.configuration.urlCache?.cachedResponse(for: request)
            print(response)
            
        }
        return term.count >= 3
    }
    
    func numberOfRows(section: Int) -> Int {
        return forecastDay?.list.count ?? 0
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func forecastAtIndex(index: Int) -> Forecast? {
        if let forecasts = forecastDay?.list, index < forecasts.count {
            return forecasts[index]
        }
        return nil
    }
}
