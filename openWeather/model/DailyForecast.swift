//
//  DailyForecast.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

// MARK: - DailyForecast
@objc class ForecastResponse: NSObject, Codable {
    let cod: String
    let cnt: Int
    let list: [Forecast]
}

// MARK: - List
struct Forecast: Codable {
    let temp: Temp
    let pressure, humidity: Int
    let weather: [Weather]
    let speed: Double
    let dt: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?
    
    func forecastDescription() -> String {
        return weather.first?.weatherDescription ?? ""
    }
    
    func getAvgTemp() -> String {
        return String(temp.day)
    }
    
    func getHumidity() -> String {
        return String(humidity)
    }
    
    func getPressure() -> String {
        return String(pressure)
    }
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.dateFormat
        return dateFormatter.string(from: Date(timeIntervalSince1970: dt))
    }
    
    func getIconUrl() -> URL? {
        let urlString = String(format: Constant.iconFormat, weather.first?.icon ?? "")
        return URL(string: urlString)
    }
}


// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
