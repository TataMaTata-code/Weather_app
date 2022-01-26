//
//  SearcherEntity.swift
//  WeatherTest
//
//  Created by Tata on 19/01/22.
//

struct SearcherEntity: Codable {
    var scene: String
    var color: String
    var lat: Double
    var long: Double
    var city: String
    var descript: String
    var temp: String
    var feelsLike: String
    var currentTime: String
}
