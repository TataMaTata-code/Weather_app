//
//  MainEntity.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

struct MainEntity: Codable {
    var city: String
    var icon: String
    var temp: String
    var descript: String
    var humidity: String
    var wind: String
    var sunrise: String
    var sunset: String
    var timezone: Float
    var hourly: [Hourly]
    var daily: [Daily]
}

struct MainIconsEntity {
    var iconsDic: Dictionary = ["01d": "sun.max.fill",
                                "01n": "moon.stars.fill",
                                
                                "02d": "cloud.sun.fill",
                                "02n": "cloud.moon.fill",
                                
                                "03d": "cloud.fill",
                                "03n": "cloud.fill",
                                
                                "04d": "smoke.fill",
                                "04n": "smoke.fill",
                                
                                "09d": "cloud.drizzle.fill",
                                "09n": "cloud.drizzle.fill",
                                
                                "10d": "cloud.sun.rain.fill",
                                "10n": "cloud.moon.rain.fill",
                                
                                "11d": "cloud.bolt.rain.fill",
                                "11n": "cloud.bolt.rain.fill",
                                
                                "13d": "snowflake",
                                "13n": "snowflake",
                                
                                "50d": "cloud.fog.fill",
                                "50n": "cloud.fog.fill"]
}
