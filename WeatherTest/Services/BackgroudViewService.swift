//
//  BackgroudViewService.swift.swift
//  WeatherTest
//
//  Created by Tata on 16/01/22.
//
import UIKit
import SpriteKit

protocol BackgroudViewService {
    func backgroudAnimation(entity: MainEntity) -> String
    func backgroudColor(entity: MainEntity) -> String
    
    func backgroudAnimationSearcher(with mapped: WeatherResponse) -> String
    func backgroudColorSearcher(with mapped: WeatherResponse) -> String
}

final class BackgroudViewServiceImp: BackgroudViewService {

    func backgroudAnimation(entity: MainEntity) -> String {
        let particleDic = WeatherNodesDictionary()
        for day in particleDic.dictionary {
            if entity.icon == day.key {
                let particle = day.value
                return particle
            }
        }
        return ""
    }

    func backgroudColor(entity: MainEntity) -> String {
        let colorDic = WeatherColorDictionary()
        for color in colorDic.dictionary {
            if entity.icon == color.key {
                let color = color.value
                return color
            }
        }
        return ""
    }
    
//    func backgroudAnimationSearcher(entity: SearcherEntity) -> String {
//        let particleDic = WeatherNodesDictionary()
//        for day in particleDic.dictionary {
//            if entity.icon == day.key {
//                let particle = day.value
//                return particle
//            }
//        }
//        return ""
//    }
    
//    func backgroudColorSearcher(entity: SearcherEntity) -> String {
//        let colorDic = WeatherColorDictionary()
//        for color in colorDic.dictionary {
//            if entity.icon == color.key {
//                let color = color.value
//                return color
//            }
//        }
//        return ""
//    }
    
    func backgroudAnimationSearcher(with mapped: WeatherResponse) -> String {
        let particleDic = WeatherNodesDictionary()
        for day in particleDic.dictionary {
            if mapped.current.weather.first?.icon == day.key {
                let particle = day.value
                return particle
            }
        }
        return ""
    }
    
    func backgroudColorSearcher(with mapped: WeatherResponse) -> String {
        let colorDic = WeatherColorDictionary()
        for color in colorDic.dictionary {
            if mapped.current.weather.first?.icon == color.key {
                let color = color.value
                return color
            }
        }
        return ""
    }
}
