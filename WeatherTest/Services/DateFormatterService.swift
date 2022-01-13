//
//  DateFormaterService.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import Foundation

protocol DateFormatterService {
    func dateFormater(dt: Float) -> String
}

final class DateFormatterServiceImp: DateFormatterService {
    func dateFormater(dt: Float) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}
