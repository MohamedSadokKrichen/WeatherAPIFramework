//
//  Weather.swift
//  WeatherAPIFramework
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import Foundation

// MARK: - Weather
public struct Weather: Codable {
    public let coord: Coord?
    public let weather: [WeatherElement]?
    public let base: String?
    public let main: Main?
    public let visibility: Int?
    public let wind: Wind?
    public let clouds: Clouds?
    public let dt: Int?
    public let sys: Sys?
    public let timezone, id: Int?
    public let name: String?
//    public let cod: Int?
}

// MARK: - Clouds
public struct Clouds: Codable {
    public let all: Int?
}

// MARK: - Coord
public struct Coord: Codable {
    public let lon, lat: Double?
}

// MARK: - Main
public struct Main: Codable {
    public let temp, feelsLike, tempMin, tempMax: Double?
    public let pressure, humidity, seaLevel, grndLevel: Int?

    public enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
public struct Sys: Codable {
    public let type, id: Int?
    public let country: String?
    public let sunrise, sunset: Int?
}

// MARK: - WeatherElement
public struct WeatherElement: Codable {
    public let id: Int?
    public let main, description, icon: String?
}

// MARK: - Wind
public struct Wind: Codable {
    public let speed: Double?
    public let deg: Int?
    public let gust: Double?
}
