//
//  Weather.swift
//  WeatherTest
//
//  Created by Tata on 19/12/21.
//
import Foundation
import CoreLocation

struct WeatherModel: Codable {
    var city: String
    var lat: CLLocationDegrees
    var long: CLLocationDegrees
}

