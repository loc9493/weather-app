//
//  apiClient.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

class WeatherService {
    private let reqProvider = RequestProvider(baseUrl: Constant.baseUrl, apiKey: Constant.apiKey() ?? "")
    private let urlSession = URLSession.shared
    
//    #https://api.openweathermap.org/data/2.5/forecast/daily?q=saigon&cnt=-1&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric
    func getDailyForecast(term: String, completion: @escaping (Result<ForecastResponse, ErrorResponse>) -> Void) {
        guard var request = reqProvider?.createRequest(endPoint: .dailyForecast, params: ["q": term, "cnt": "7", "unit":"metric"]) else {
            completion(.failure(ErrorResponse(error: .BadRequest)))
            return
        }
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode), let data = data {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    completion(.failure(errorResponse))
                } catch _ {
                    completion(.failure(ErrorResponse(error: .ParseError)))
                }
                return
            }
            
            if let error = error, data == nil, response == nil {
                completion(.failure(ErrorResponse(error: error as NSError)))
                return
            }
            do {
                let response = try decoder.decode(ForecastResponse.self, from: data ?? Data())
                completion(.success(response))
            } catch let parseError {
                completion(.failure(ErrorResponse(error: .ParseError)))
            }
        }
        task.resume()
    }
}


class RequestProvider {
    private var baseURL: URL
    private var apiKey: String
    init?(baseUrl: String, apiKey: String) {
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        self.apiKey = apiKey
        baseURL = url
    }
    
    func createRequest(endPoint: ApiEndpoint, params: [String: String]) -> URLRequest? {
        var urlComponent = URLComponents(string: endPoint.path())
        var urlQuery: [URLQueryItem] = []
        for key in params.keys {
            let query = URLQueryItem(name: key, value: params[key])
            urlQuery.append(query)
        }
        urlQuery.append(URLQueryItem(name: "appid", value: apiKey))
        urlComponent?.queryItems = urlQuery
        
        if let url = urlComponent?.url(relativeTo: baseURL) {
            print(url)
            let request = URLRequest(url: url)
            
            return request
        }
        return nil
    }
}

enum ApiEndpoint {
    case dailyForecast
    func path() -> String {
        switch self {
        case .dailyForecast:
            return "forecast/daily"
        }
    }
}
