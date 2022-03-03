//
//  Constant.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

struct Constant {
    static var apiKey = {
        return Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String
    }
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static let iconFormat = "https://openweathermap.org/img/wn/%@@2x.png"
    static let dateFormat = "EEE, dd MMM yyyy"
}
