//
//  WeatherResponse.swift
//  WeatherTest
//
//  Created by Tata on 20/11/21.
//

struct WeatherResponse: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}
struct Current: Codable {
    let sunrise: Float
    let sunset: Float
    let temp: Float
    let humidity: Float
    let wind_speed: Float
    let feels_like: Float
    let dt: Float
    let weather: [Weather]
}
struct Weather: Codable {
    let description: String
    let main: String
    let icon: String
}
struct Hourly: Codable {
    let dt: Float
    let temp: Float
    let weather: [WeatherHourly]
}
struct WeatherHourly: Codable {
    let icon: String
}
struct Daily: Codable {
    let dt: Float
    let temp: Temp
    let weather: [WeatherDaily]
}
struct Temp: Codable {
    let min: Float
    let max: Float
}
struct WeatherDaily: Codable {
    let icon: String
}










//struct WeatherResponse: Codable {
//    let list: [ListStruct]
//    let city: City
//}
//
//struct City: Codable {
//    let name: String
//}
//
//struct ListStruct: Codable {
//    let dt: Float
//    let main: MainStruct
//    let weather: [WeatherStruct]
//    let wind: WindSpeed
//}
//
//struct MainStruct: Codable {
//    let temp: Float
//    let humidity: Float
//}
//
//struct WeatherStruct: Codable {
//    let main: String
//    let icon: String
//}
//
//struct WindSpeed: Codable {
//    let speed: Float
//}

