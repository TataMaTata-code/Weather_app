//
//  BackgroundModel.swift
//  WeatherTest
//
//  Created by Tata on 16/01/22.
//

import UIKit

struct BackgroundModel: Codable {
    var beginColor: String
    var endColor: String
    var node: String
    var secondNode: String
}

struct WeatherBackgroundDictionary {
    
//    01d
    private let sunnyDay = BackgroundModel(beginColor: "#1c92d2", endColor: "#BDC7D9", node: "SunParticle", secondNode: " ")
//    01n
    private let clearNight = BackgroundModel(beginColor: "#0f0c29", endColor: "#302b63", node: "StarsParticle", secondNode: " ")
//    02d
    private let cloudsWithSun = BackgroundModel(beginColor: "#6190E8", endColor: "#A7BFE8", node: "SunParticle", secondNode: "CloudsParticle")
//    02n
    private let nightClearClouds = BackgroundModel(beginColor: "#0f0c29", endColor: "#302b63", node: "StarsParticle", secondNode: "CloudsParticle")
//    03d
    private let clouds = BackgroundModel(beginColor: "#457fca", endColor: "#5691c8", node: " ", secondNode: "CloudsParticle")
//    03n
    private let cloudsNight = BackgroundModel(beginColor: "#1F1C2C", endColor: "#1D2B64", node: " ", secondNode: "CloudsParticle")
//    04d
    private let overcast = BackgroundModel(beginColor: "#3f4c6b", endColor: "#606c88", node: " ", secondNode: "OvercastParticle")
//    04n
    private let overcastNight = BackgroundModel(beginColor: "#232526", endColor: "#292E49", node: " ", secondNode: "OvercastParticle")
//    09d
    private let rainyDay = BackgroundModel(beginColor: "#32495C", endColor: "#32495C", node: "RainParticle", secondNode: " ")
//    09n
    private let rainyNight = BackgroundModel(beginColor: "#1B2030", endColor: "#1B2030", node: "RainParticle", secondNode: " ")
//    10d
    private let rainSun = BackgroundModel(beginColor: "#575D78", endColor: "#575D78", node: "RainParticle", secondNode: " ")
//    10n
    private let rainClearNight = BackgroundModel(beginColor: "#1B2030", endColor: "#1B2030", node: "RainParticle", secondNode: " ")
//    11d
    private let rainWithClouds = BackgroundModel(beginColor: "#324051", endColor: "#324051", node: "RainParticle", secondNode: "OvercastParticle")
//    11n
    private let rainWithCloudsNight = BackgroundModel(beginColor: "#324051", endColor: "#324051", node: "RainParticle", secondNode: "OvercastParticle")
//    13d
    private let snow = BackgroundModel(beginColor: "#2c3e50", endColor: "#bdc3c7", node: "SnowParticle", secondNode: " ")
//    13n
    private let snowNight = BackgroundModel(beginColor: "#1D2530", endColor: "#252F3C", node: "SnowParticle", secondNode: " ")
//    50d
    private let fog = BackgroundModel(beginColor: "#29323c", endColor: "#485563", node: "FogParticle", secondNode: " ")
//    50n
    private let fogNight = BackgroundModel(beginColor: "#232526", endColor: "#414345", node: "FogParticle", secondNode: " ")
    
    lazy var dictionary: [String: BackgroundModel] = ["01d": sunnyDay,
                      "01n": clearNight,
                      "02d": cloudsWithSun,
                      "02n": nightClearClouds,
                      "03d": clouds,
                      "03n": cloudsNight,
                      "04d": overcast,
                      "04n": overcastNight,
                      "09d": rainyDay,
                      "09n": rainyNight,
                      "10d": rainSun,
                      "10n": rainClearNight,
                      "11d": rainWithClouds,
                      "11n": rainWithCloudsNight,
                      "13d": snow,
                      "13n": snowNight,
                      "50d": fog,
                      "50n": fogNight]
    
}

