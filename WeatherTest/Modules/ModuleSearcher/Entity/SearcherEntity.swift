//
//  SearcherEntity.swift
//  WeatherTest
//
//  Created by Tata on 19/01/22.
//

struct SearcherEntity: Codable {
    var background: BackgroundModel
    var lat: Double
    var long: Double
    var city: String
    var descript: String
    var temp: String
    var feelsLike: String
    var currentTime: String
}
