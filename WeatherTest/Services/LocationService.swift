//
//  LocationService.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import CoreLocation

protocol LocationService {
    func geoCodingCoordinates(currentLocation: CLLocation, completion: @escaping (String, CLLocationDegrees, CLLocationDegrees) -> ())
    func geoCodingAddress(city: String, completion: @escaping (CLLocation) -> ())
}

//MARK: - Implementation

final class LocationServiceImp: LocationService {
    
    func geoCodingCoordinates(currentLocation: CLLocation, completion: @escaping (String, CLLocationDegrees, CLLocationDegrees) -> ()) {
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placeMark = placemarks?.first {
                if let city = placeMark.subAdministrativeArea {
                    completion(city, lat, long)
                } else {
                    print("Error with reversing geocode location")
                }
            }
        }
    }
    func geoCodingAddress(city: String, completion: @escaping (CLLocation) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { coordinate, error in
            DispatchQueue.main.async {
                guard let location = coordinate?.first?.location else { return }
                completion(location)
            }
        }
    }
}
