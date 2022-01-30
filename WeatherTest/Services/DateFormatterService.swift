//
//  DateFormaterService.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import Foundation

protocol DateFormatterService {
    func dateFormatter(dt: Int, format: String, offset: Int) -> String
    func dateFormatterWithTimeZone(format: String, dt: Int, offset: Int) -> String
}

final class DateFormatterServiceImp: DateFormatterService {
    func dateFormatter(dt: Int, format: String, offset: Int) -> String {
        let today = "Today"
        
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateOffset = Date(timeInterval: TimeInterval(offset), since: date)

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "E d"
                
        let dateString = formatter.string(from: dateOffset)
        let relativeDateString = formatter.string(from: Date())
        
        if dateString == relativeDateString {
            return today
        } else {
            formatter.dateFormat = format
            return formatter.string(from: dateOffset)
        }
    }
    
    func dateFormatterWithTimeZone(format: String, dt: Int, offset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateOffset = Date(timeInterval: TimeInterval(offset), since: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dateString = formatter.string(from: dateOffset)
        return dateString
        
    }
}
