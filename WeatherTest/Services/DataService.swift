//
//  DataService.swift
//  WeatherTest
//
//  Created by Tata on 19/01/22.
//


protocol DataServiceDelegate: AnyObject {
    
    func updateModel(with model: WeatherModel)
    func updateEntity(with entity: MainEntity)
}

final class DataService {
    weak var delegate: DataServiceDelegate?
}

