//
//  Constants.swift
//  WeatherAPIFramework
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import Foundation


struct Constants {
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
    static let apiKey = "975365616f8e7f77a169c4f33bd8438c"
}

enum Units: String {
    case metric
    case imperial
    case standard
}
