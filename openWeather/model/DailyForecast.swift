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
    let message: Double
    let cnt: Int
    let list: [Forecast]
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
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
    
    func forecastDescription() -> String? {
        return weather.first?.weatherDescription
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
