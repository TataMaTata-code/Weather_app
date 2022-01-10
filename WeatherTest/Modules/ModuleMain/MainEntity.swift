//
//  MainEntity.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

struct MainEntity: Codable {
    var city: String
    var temp: String
    var descript: String
    var humidity: String
    var wind: String
    var daily: [Daily]
}
