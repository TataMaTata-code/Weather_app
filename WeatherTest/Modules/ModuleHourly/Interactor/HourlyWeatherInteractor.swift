//
//  HourlyWeatherInteractor.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import Foundation

protocol HourlyWeatherInteractorInput {
    var output: HourlyWeatherInteracorOutput? { get set }
//    func getCityName(with model: WeatherModel)
}

protocol HourlyWeatherInteracorOutput: AnyObject {
    func updateEntity(with entity: HourlyWeatherEntity)
}

//MARK: - Implementation

final class HourlyWeatherInteracorImp: HourlyWeatherInteractorInput {
    
    
    weak var output: HourlyWeatherInteracorOutput?
    
    let weatherService: WeatherDataService = WeatherDataServiceImp()
    
    var entity: HourlyWeatherEntity?
    
//    func getCityName(with model: WeatherModel) {
//        weatherService.loadWeatherData(city: model.city) { [weak self] mapped in
//            let temp = "\(mapped.list.first?.main.temp ?? 0)"
//            let newEntity = HourlyWeatherEntity(temp: temp)
//            self?.output?.updateEntity(with: newEntity)
//        }
//    }
}
