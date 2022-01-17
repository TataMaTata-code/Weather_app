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
}
