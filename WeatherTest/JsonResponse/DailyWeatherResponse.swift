//
//  DailyWeatherResponse.swift
//  WeatherTest
//
//  Created by Tata on 20/11/21.
//

import Foundation

struct DailyWeatherResponse: Codable {
    let daily: [Daily]
}

struct Daily: Codable {
    let dt: Float
    let temp: Temp
    let weather: [WeatherIcon]

}

struct Temp: Codable {
    let day: Float
}

struct WeatherIcon: Codable {
    let icon: String
}
