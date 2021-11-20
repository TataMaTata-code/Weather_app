//
//  Constans.swift
//  WeatherTest
//
//  Created by Tata on 20/11/21.
//

enum Constants {
    enum CurrentWeatherForecast {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
        static let apiKey = "e20e931c0ab70e242dfb4693aab476da"
    }
    enum DailyWeatherForecast {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?"
        static let apiKey = "e20e931c0ab70e242dfb4693aab476da"
    }
}
