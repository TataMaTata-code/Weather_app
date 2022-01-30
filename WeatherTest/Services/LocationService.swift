//
//  LocationService.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import CoreLocation

protocol LocationService {
    func geoCodingCoordinates(currentLocation: CLLocation, completion: @escaping (String?, CLLocationDegrees?, CLLocationDegrees?, Error?) -> ())
    func geoCodingAddress(city: String, completion: @escaping (CLLocation?, Error?) -> ())
}

//MARK: - Implementation

final class LocationServiceImp: LocationService {
    
    func geoCodingCoordinates(currentLocation: CLLocation, completion: @escaping (String?, CLLocationDegrees?, CLLocationDegrees?, Error?) -> ()) {
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placeMark = placemarks?.first {
                if let city = placeMark.locality {
                    completion(city, lat, long, nil)
                } else {
                    print("Error with reversing geocode location")
                }
            } else {
                completion(nil, nil, nil, error)
            }
        }
    }
    func geoCodingAddress(city: String, completion: @escaping (CLLocation? , Error?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { coordinate, error in
            if error == nil {
                DispatchQueue.main.async {
                    guard let location = coordinate?.first?.location else { return }
                    completion(location, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
