//
//  Module.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

protocol ModuleInput {
    var model: WeatherModel? { get set }
}

protocol ModuleOuput: AnyObject {
    func didUpdateModel(model: WeatherModel)
}
