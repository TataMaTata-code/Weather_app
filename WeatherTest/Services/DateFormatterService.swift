//
//  DateFormaterService.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import Foundation

protocol DateFormatterService {
    func dateFormater(with entity: MainEntity, indexPath: IndexPath) -> String
}

final class DateFormatterServiceImp: DateFormatterService {
    func dateFormater(with entity: MainEntity, indexPath: IndexPath) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(entity.daily[indexPath.row].dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}
