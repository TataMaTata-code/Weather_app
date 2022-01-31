//
//  CoreDataService.swift
//  WeatherTest
//
//  Created by Tata on 29/01/22.
//

import UIKit
import Foundation

protocol CoreDataService {
    func saveModel(with model: WeatherModel)
    func fetchModel() -> WeatherCityModel?
    
}

final class CoreDataServiceImp: CoreDataService {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveModel(with model: WeatherModel) {
        let newModel = WeatherCityModel(context: context)
        newModel.city = model.city
        newModel.lat = model.lat
        newModel.long = model.long
        
        context.perform {
            try? self.context.save()
        }
        
    }
    
    func fetchModel() -> WeatherCityModel? {
        guard let model = try? context.fetch(WeatherCityModel.fetchRequest()) else { return nil }
        return model.last
    }
}
