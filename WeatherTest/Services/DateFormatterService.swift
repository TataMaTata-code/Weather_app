//
//  DateFormaterService.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import Foundation

protocol DateFormatterService {
    func dateFormater(dt: Float, format: String) -> String
}

final class DateFormatterServiceImp: DateFormatterService {
    func dateFormater(dt: Float, format: String) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = format
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}
