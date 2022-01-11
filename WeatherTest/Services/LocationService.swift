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
    var currentCity = ""

    func geoCodingCoordinates(currentLocation: CLLocation, completion: @escaping (String, CLLocationDegrees, CLLocationDegrees) -> ()) {
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placeMark = placemarks?.first else { return }
            if let city = placeMark.subAdministrativeArea {
                if self?.currentCity == "" {
                    self?.currentCity = city
                    completion(city, lat, long)
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
