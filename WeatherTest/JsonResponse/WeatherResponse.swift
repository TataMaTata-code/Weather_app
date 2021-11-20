//
//  WeatherResponse.swift
//  WeatherTest
//
//  Created by Tata on 20/11/21.
//

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Weather: Codable {
    let main: String
    let description: String
    
}

struct Main: Codable {
    let temp: Float
    let humidity: Float
}

struct Wind: Codable {
    let speed: Float
}

