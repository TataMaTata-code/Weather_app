//
//  WeatherDataService.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//
import UIKit
import CoreLocation
import Alamofire

protocol WeatherDataService {
    func loadWeatherData(lat: CLLocationDegrees, long: CLLocationDegrees, completion: @escaping (WeatherResponse?, Error?) -> ())
    func prepareLoadDataRequest(lat: CLLocationDegrees, long: CLLocationDegrees) -> String
}

//MARK: - Implementation

final class WeatherDataServiceImp: WeatherDataService {    
    func loadWeatherData(lat: CLLocationDegrees, long: CLLocationDegrees, completion: @escaping (WeatherResponse?, Error?) -> ()) {
        AF.request(prepareLoadDataRequest(lat: lat, long: long)).response { response in
            do {
                if let data = response.data {
                    let mapped = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(mapped, nil)
                } else if let error = response.error {
                    completion(nil, error)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func prepareLoadDataRequest(lat: CLLocationDegrees, long: CLLocationDegrees) -> String {
        var components = URLComponents(string: Constants.baseUrl)
        components?.queryItems = [URLQueryItem(name: Parameters.lat, value: "\(lat)"),
                                  URLQueryItem(name: Parameters.lon, value: "\(long)"),
                                  URLQueryItem(name: Parameters.exclude, value: Parameters.exclusion),
                                  URLQueryItem(name: Parameters.units, value: Parameters.metric),
                                  URLQueryItem(name: Parameters.appid, value: Constants.apiKey)]
        
        guard let url = components?.url else { return "" }
        
        return "\(url)"
    }
}
