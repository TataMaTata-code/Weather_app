//
//  BackgroudViewService.swift.swift
//  WeatherTest
//
//  Created by Tata on 16/01/22.
//
import UIKit
import SpriteKit

protocol BackgroudViewService {
    func backgroudConfigWithEntity(entity: MainEntity) -> BackgroundModel
    func backgroundConfigWithModel(with mapped: WeatherResponse) -> BackgroundModel

}

final class BackgroudViewServiceImp: BackgroudViewService {
    func backgroudConfigWithEntity(entity: MainEntity) -> BackgroundModel {
        var dictionaryModel = WeatherBackgroundDictionary()
        let dic = dictionaryModel.dictionary
        for model in dic {
            if entity.icon == model.key {
                let newModel = model.value
                return newModel
            }
        }
        return BackgroundModel(beginColor: "", endColor: "", node: "", secondNode: "")
    }
    
    func backgroundConfigWithModel(with mapped: WeatherResponse) -> BackgroundModel {
        var dictionaryModel = WeatherBackgroundDictionary()
        let dic = dictionaryModel.dictionary
        for model in dic {
            if mapped.current.weather.first?.icon == model.key {
                let newModel = model.value
                return newModel
            }
        }
        return BackgroundModel(beginColor: "", endColor: "", node: "", secondNode: "")
    }
}
