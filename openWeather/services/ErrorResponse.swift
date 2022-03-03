//
//  ErrorResponse.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let cod: String
    let message: String
    
    init(error: NSError) {
        cod = error.code.description
        message = error.localizedDescription
    }
    
    init(error: NetworkError) {
        cod = ""
        message = error.errorDescription ?? ""
    }
}
