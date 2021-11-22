//
//  DailyWeatherResponse.swift
//  WeatherTest
//
//  Created by Tata on 20/11/21.
//

//import Foundation
//
//struct DailyWeatherResponse: Codable {
//    let daily: [Daily]
//}
//
//struct Daily: Codable {
//    let dt: Float
//    let temp: Temp
//    let weather: [WeatherIcon]
//
//}
//
//struct Temp: Codable {
//    let day: Float
//}
//
//struct WeatherIcon: Codable {
//    let icon: String
//}
//

struct DailyWeatherResponse: Codable {
    let list: [ListStruct]
}

struct ListStruct: Codable {
    let dt: Float
    let main: MainStruct
    let weather: [WeatherStruct]
}

struct MainStruct: Codable {
    let temp: Float
}

struct WeatherStruct: Codable {
    let icon: String
}
