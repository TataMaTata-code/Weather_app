//
//  DateFormaterService.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import Foundation

protocol DateFormatterService {
    func dateFormatter(dt: Int, format: String) -> String
    func dateFormatterWithTimeZone(format: String, dt: Int, offset: Int) -> String
}

final class DateFormatterServiceImp: DateFormatterService {
    func dateFormatter(dt: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = format
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    }
    
    func dateFormatterWithTimeZone(format: String, dt: Int, offset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateOffset = Date(timeInterval: TimeInterval(offset), since: date)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = format
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dateString = dayTimePeriodFormatter.string(from: dateOffset)
        return dateString
        
    }
}
