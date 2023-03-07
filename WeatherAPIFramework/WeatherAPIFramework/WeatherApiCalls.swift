//
//  WeatherApiCalls.swift
//  WeatherAPIFramework
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import Foundation


public class WeatherApiCalls {
    
    public static let shared = WeatherApiCalls()
    
    public func getWeatherInfo(for country: String,
                               completion: @escaping (Result<Weather, Error>) -> Void){
        let queryParameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: country),
            URLQueryItem(name: "units", value: Units.metric.rawValue),
            URLQueryItem(name: "appid", value: Constants.apiKey)
        ]
        let request = WFRequest(endPoint: .weather, queryParameters: queryParameters)
        WFService.shared.execute(request, expecting: Weather.self) { result in
            switch result {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
